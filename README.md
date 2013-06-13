syslog-message-keyvalue [![Build Status](https://travis-ci.org/CamShaft/syslog-message-keyvalue.png)](https://travis-ci.org/CamShaft/syslog-message-keyvalue)
=============

Parse 'key=value' style syslogs

Usage
-----

TODO

Testing
-------

```sh
make test
```

Benchmarks
----------

```sh
$  make bench
./rebar compile
==> syslog-message-keyvalue (compile)
./test/benchmark
500000 iterations in 3.037699s
164598.2699405043 messages/sec
```
