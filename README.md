# Parse Fight

This project is a demonstration of a
[autohelp](https://github.com/stolen/autohelp) crash on build. It's a default
rebar/erlang project. Run

    ./rebar get-deps
    ./rebar compile

to reproduce. From my own system:

```
> ./rebar clean && ./rebar compile
==> autohelp (clean)
==> bson (clean)
==> mongodb (clean)
==> parse_fight (clean)
==> parse_fight (clean)
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
Compiled src/mongodb_tests.erl
Compiled src/mongo_protocol.erl
Compiled src/mongo_cursor.erl
Compiled src/mongo_connect.erl
Compiled src/mongo.erl
==> parse_fight (compile)
Compiled src/behave.erl
Compiled src/parse_fight_sup.erl
Compiled src/parse_fight_app.erl
Compiled src/db_wrapper.erl
==> parse_fight (compile)

(walden) ~/projects/com/rackspace/parse_fight
blt> erl -boot start_sasl -pa deps/*/ebin -pa apps/*/ebin -s parse_fight_app
Erlang R15B02 (erts-5.9.2) [source] [64-bit] [smp:8:8] [async-threads:0] [hipe] [kernel-poll:false]


=PROGRESS REPORT==== 4-Feb-2013::12:10:36 ===
          supervisor: {local,sasl_safe_sup}
             started: [{pid,<0.34.0>},
                       {name,alarm_handler},
                       {mfargs,{alarm_handler,start_link,[]}},
                       {restart_type,permanent},
                       {shutdown,2000},
                       {child_type,worker}]

=PROGRESS REPORT==== 4-Feb-2013::12:10:36 ===
          supervisor: {local,sasl_safe_sup}
             started: [{pid,<0.35.0>},
                       {name,overload},
                       {mfargs,{overload,start_link,[]}},
                       {restart_type,permanent},
                       {shutdown,2000},
                       {child_type,worker}]

=PROGRESS REPORT==== 4-Feb-2013::12:10:36 ===
          supervisor: {local,sasl_sup}
             started: [{pid,<0.33.0>},
                       {name,sasl_safe_sup},
                       {mfargs,
                           {supervisor,start_link,
                               [{local,sasl_safe_sup},sasl,safe]}},
                       {restart_type,permanent},
                       {shutdown,infinity},
                       {child_type,supervisor}]

=PROGRESS REPORT==== 4-Feb-2013::12:10:36 ===
          supervisor: {local,sasl_sup}
             started: [{pid,<0.36.0>},
                       {name,release_handler},
                       {mfargs,{release_handler,start_link,[]}},
                       {restart_type,permanent},
                       {shutdown,2000},
                       {child_type,worker}]

=PROGRESS REPORT==== 4-Feb-2013::12:10:36 ===
         application: sasl
          started_at: nonode@nohost
Eshell V5.9.2  (abort with ^G)
1> db_wrapper:help(find, 2).
    find(Collection, Selector)

ok
```

The documentation that should appear can be seen in `apps/parse_fight/src/db_wrapper.erl`.