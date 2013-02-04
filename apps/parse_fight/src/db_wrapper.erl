-module(db_wrapper).
-include_lib("include/fight.hrl").

%% API
-export([find/2, find/3]).
-export([record_to_proplist/1, proplist_to_record/2]).

-record(fjord, {name, location}).
-record(viking, {home_fjord, treasure_value}).
-record(knight, {has_legs :: boolean(), vikings_killed}).

-define(R2P(Record), record_to_proplist(#Record{} = Rec) ->
            lists:zip(record_info(fields, Record), tl(tuple_to_list(Rec)))).

-define(P2R(Record), proplist_to_record(Record, Props) ->
            list_to_tuple([Record|[proplists:get_value(X, Props) ||
                            X <- record_info(fields, Record)]])).


?R2P(fjord); ?R2P(viking); ?R2P(knight).
?P2R(fjord); ?P2R(viking); ?P2R(knight).

%%%===================================================================
%%% API
%%%===================================================================

%%-----------------------------------------------------------------------------
%% @doc Your description goes here
%%
%% Your longer explanation goes here. Include multiple paragraphs and an
%% example or two.
%%
%% @end
%%-----------------------------------------------------------------------------
find(Collection, Selector) when is_tuple(Selector) ->
    {ok, Docs} = do(safe, slave_ok,
        fun() ->
                Cursor = mongo:find(Collection, Selector),
                mongo:rest(Cursor)
        end),
    documents_to_record_list(Collection, Docs).

find(Collection, Query, Options) ->
    {ok, Docs} = do(safe, slave_ok,
        fun() ->
                Skip = bson:lookup('$skip', Options),
                Batch = bson:lookup('$batchsize', Options),
                Selector = bson:append({'$query', Query},
                            bson:exclude(['$skip', '$batchsize'], Options)),

                Cursor = case {Skip, Batch} of
                    {{}, {}} ->
                        mongo:find(Collection, Selector);

                    {{S}, {}} ->
                        mongo:find(Collection, Selector, {}, S);

                    {{}, {B}} ->
                        mongo:find(Collection, Selector, {}, 0, -B);

                    {{S}, {B}} ->
                        mongo:find(Collection, Selector, {}, S, -B)
                end,
                mongo:rest(Cursor)
        end),
    documents_to_record_list(Collection, Docs).

%%%===================================================================
%%% Internal functions
%%%===================================================================

do(W, R, Fun) ->
    {ok, DB} = application:get_env(fe_db, mongodb_db_name),
    case mongo:do(W, R, fe_db_pool:get(), DB, Fun) of
        {ok, ok} -> ok;
        {ok, {ok, _}=Ret} -> Ret;
        {failure, {connection_failure, _Connection, Reason}} ->
            {error, Reason};
        {failure, {write_failure, Code, Msg}} ->
            Reason = list_to_binary(io_lib:format("Error ~B: ~s", [Code, Msg])),
            {error, Reason};
        {failure, {cursor_expired, _Cursor}} -> {error, cursor_expired};
        {failure, Reason} -> {error, Reason};
        X -> X
    end.

singularize(Name) ->
    NameString = atom_to_list(Name),
    list_to_atom(string:left(NameString, length(NameString) - 1)).

document_to_record(RecName, Doc) ->
    proplist_to_record(RecName, bson:fields(Doc)).

documents_to_record_list(Collection, Docs) ->
    RecName = singularize(Collection),
    [document_to_record(RecName, D) || D <- Docs].
