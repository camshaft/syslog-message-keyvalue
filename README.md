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
$ make bench
./rebar compile
==> syslog-message-keyvalue (compile)
./test/benchmark
100000 iterations in 1.400548s
71400.62318463916 messages/sec
```
