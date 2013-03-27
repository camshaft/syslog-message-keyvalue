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
100000 iterations in 0.949733s
105292.75069940709 messages/sec
```
