-module(parse_fight_app).

-behaviour(application).

%% Application callbacks
-export([start/0, start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start() ->
    application:start(parse_fight_app).

start(_StartType, _StartArgs) ->
    parse_fight_sup:start_link().

stop(_State) ->
    ok.
