-module (syslog_message_keyvalue_test).

-include_lib("eunit/include/eunit.hrl").

-define (PARSE_TESTS, [
  {
    <<"testing=123">>,
    [{<<"testing">>,<<"123">>}]
  },
  {
    <<"testing=\"this is a test\"">>,
    [{<<"testing">>,<<"this is a test">>}]
  },
  {
    <<"testing=\"this\\\" is a test\"">>,
    [{<<"testing">>,<<"this\" is a test">>}]
  },
  {
    <<"unit=ms testing=123 testing=\"this is a test\" testing=\"this\\\" is a test\"">>,
    [{<<"unit">>,<<"ms">>},{<<"testing">>,<<"123">>},{<<"testing">>,<<"this is a test">>},{<<"testing">>,<<"this\" is a test">>}]
  },
  {
    <<"source=heroku.6041702.web.1.dabb0da6-d9d5-4627-a299-0b218adf1d3e measure=load_avg_1m val=0.00\n">>,
    [{<<"source">>,<<"heroku.6041702.web.1.dabb0da6-d9d5-4627-a299-0b218adf1d3e">>},{<<"measure">>,<<"load_avg_1m">>},{<<"val">>,<<"0.00">>}]
  },
  {
    <<"    source=heroku.6041702.web.1.dabb0da6-d9d5-4627-a299-0b218adf1d3e    measure=load_avg_1m  val=0.00         \n">>,
    [{<<"source">>,<<"heroku.6041702.web.1.dabb0da6-d9d5-4627-a299-0b218adf1d3e">>},{<<"measure">>,<<"load_avg_1m">>},{<<"val">>,<<"0.00">>}]
  },
  {
    <<"at=info method=GET path=/ host=my-cool-test.herokuapp.com request_id=755159ef5cfc715185a43e664d0be6c8 fwd=\"216.49.181.254, 204.9.229.1\" dyno=web.1 queue=0 wait=0ms connect=1ms service=364ms status=200 bytes=20946\n">>,
    [
      {<<"at">>,<<"info">>},
      {<<"method">>,<<"GET">>},
      {<<"path">>,<<"/">>},
      {<<"host">>,<<"my-cool-test.herokuapp.com">>},
      {<<"request_id">>,<<"755159ef5cfc715185a43e664d0be6c8">>},
      {<<"fwd">>,<<"216.49.181.254, 204.9.229.1">>},
      {<<"dyno">>,<<"web.1">>},
      {<<"queue">>,<<"0">>},
      {<<"wait">>,<<"0ms">>},
      {<<"connect">>,<<"1ms">>},
      {<<"service">>,<<"364ms">>},
      {<<"status">>,<<"200">>},
      {<<"bytes">>,<<"20946">>}
    ]
  }
]).

parse_test_()->
  [fun() -> run_parse_test(Test) end || Test <- ?PARSE_TESTS].
run_parse_test({Message, Expected})->
  {ok, Msg} = syslog_message_keyvalue:parse(Message),
  ?assertEqual(Expected, lists:reverse(Msg)).
