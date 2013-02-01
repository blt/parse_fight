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
                           {tag,"198a908d6fca517fd9da8c9a2335fd28baaaef4b"}}
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
src/bson_binary.erl: at line 6: can't find include file "bson_binary.hrl"
autohelp: edoc:get_doc crashed with exit:error on src/bson_binary.erl
autohelp WARNING: cannot retrieve documentation from src/bson_binary.erl. Run edoc:get_doc("src/bson_binary.erl") manually to investigate problem
Compiled src/bson_binary.erl
Compiled src/bson_tests.erl
Compiled src/bson.erl
==> mongodb (compile)
Compiled src/resource_pool.erl
Compiled src/mongodb_app.erl
Compiled src/mvar.erl
Compiled src/mongo_query.erl
Compiled src/mongo_replset.erl
Compiled src/mongodb_tests.erl
Compiled src/mongo_protocol.erl
Compiled src/mongo_cursor.erl
Compiled src/mongo_connect.erl
Compiled src/mongo.erl
==> parse_fight (compile)
Compiled src/behave.erl
src/db_wrapper.erl: at line 2: can't find include lib "include/fight.hrl"
autohelp: edoc:get_doc crashed with exit:error on src/db_wrapper.erl
autohelp WARNING: cannot retrieve documentation from src/db_wrapper.erl. Run edoc:get_doc("src/db_wrapper.erl") manually to investigate problem
Compiled src/parse_fight_sup.erl
Compiled src/parse_fight_app.erl
Compiled src/db_wrapper.erl
```