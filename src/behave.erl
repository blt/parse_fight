-module(behave).

-export_type([handle/0, result/0]).

%% ====================================================================
%% Behaviour Support
%% ====================================================================

-type handle() :: any().
-type result() :: binary().

-callback connect(string()) -> {ok, behave:handle()} | error.
-callback disconnect(behave:handle()) -> ok.
-callback wait_for(behave:handle(), string()) -> {ok, behave:result()}.
