# Parse Fight

This project is a demonstration of a
[autohelp](https://github.com/stolen/autohelp) crash on build. It's a default
rebar/erlang project. Run

    ./rebar get-deps
    ./rebar compile

to reproduce. From my own system:

```
> yes | rm -rf deps && ./rebar clean && ./rebar get-deps && ./rebar compile
==> parse_fight (clean)
==> parse_fight (get-deps)
Pulling autohelp from {git,"git://github.com/stolen/autohelp.git",
                           {tag,"a6a688a11c3e6923cb4ff7be7b06b349e3ed2cf4"}}
Cloning into 'autohelp'...
Pulling bson from {git,"git://github.com/mongodb/bson-erlang.git",
                       {tag,"17373ef4"}}
Cloning into 'bson'...
Pulling mongodb from {git,"git://github.com/mongodb/mongodb-erlang.git",
                          {tag,"bc41adb0"}}
Cloning into 'mongodb'...
==> autohelp (get-deps)
==> bson (get-deps)
==> mongodb (get-deps)
==> autohelp (compile)
Compiled src/autohelp.erl
Compiled src/autohelp_lib.erl
Compiled src/autohelp_demo.erl
==> bson (compile)
Compiled src/bson_tests.erl
Compiled src/bson.erl
Compiled src/bson_binary.erl
==> mongodb (compile)
Compiled src/resource_pool.erl
Compiled src/mvar.erl
Compiled src/mongodb_app.erl
Compiled src/mongo_query.erl
Compiled src/mongo_replset.erl
Compiled src/mongo_protocol.erl
Compiled src/mongodb_tests.erl
Compiled src/mongo_cursor.erl
Compiled src/mongo_connect.erl
Compiled src/mongo.erl
==> parse_fight (compile)
src/behave.erl:0: attribute 'export' after function definitions
src/behave.erl:0: Warning: function '__autohelp_fun_desc'/0 is unused
src/behave.erl:0: Warning: function '__autohelp_pad_text_left'/2 is unused
src/behave.erl:0: Warning: function help/0 is unused
src/behave.erl:0: Warning: function help/1 is unused
src/behave.erl:0: Warning: function help/2 is unused
ERROR: compile failed while processing /Users/blt/projects/com/rackspace/parse_fight: rebar_abort
```