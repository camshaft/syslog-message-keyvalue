%%
%% syslog_message_keyvalue.erl
%%
-module (syslog_message_keyvalue).

-export([parse/1]).

%% @doc Parse a 'key=value' formatted message
%% @public
-spec parse(binary()) -> {ok, [{binary(), binary()}]}.
parse(Message)->
  find_key(Message, [], <<>>, <<>>).


%% @doc Find a key
%% @private
-spec find_key(binary(), [{binary(), binary()}], binary(), binary()) -> {ok, [{binary(), binary()}]}.
find_key(<<" ",Rest/binary>>, Parts, <<>> = Key, <<>> = Value)->
  find_key(Rest, Parts, Key, Value);
find_key(<<C:1/binary,Rest/binary>>, Parts, _, Value)->
  parse_key(Rest, Parts, C, Value);
find_key(<<>>, Parts, _, _)->
  {ok, Parts}.

%% Key

%%    end
-spec parse_key(binary(), [{binary(), binary()}], binary(), binary()) -> {ok, [{binary(), binary()}]}.
parse_key(<<>>, Parts, _, _)->
  {ok, Parts};
parse_key(<<$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, Key, Value);

%% Adds another 20,000 msg/sec on 2Ghz i7 - I know it's ugly
parse_key(<<C:1/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:2/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:3/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:4/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:5/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:6/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:7/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:8/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:9/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:10/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:11/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:12/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:13/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:14/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:15/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:16/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:17/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:18/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:19/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:20/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:21/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:22/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:23/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:24/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:25/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:26/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:27/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:28/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:29/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:30/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:31/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);
parse_key(<<C:32/binary,$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, <<Key/binary,C/binary>>, Value);

%%    append
parse_key(<<C:1/binary,Rest/binary>>, Parts, Key, Value)->
  parse_key(Rest, Parts, <<Key/binary,C/binary>>, Value).

%% Transition state
start_value(<<$", Rest/binary>>, Parts, Key, Value)->
  parse_value(Rest, Parts, Key, Value, true);
start_value(Rest, Parts, Key, Value)->
  parse_value(Rest, Parts, Key, Value, false).

%% Value
-spec parse_value(binary(), [{binary(), binary()}], binary(), binary(), boolean()) -> {ok, [{binary(), binary()}]}.
parse_value(<<"\\\"",Rest/binary>>, Parts, Key, Value, true)->
  parse_value(Rest, Parts, Key, <<Value/binary,$">>, true);
parse_value(<<"\\\\",Rest/binary>>, Parts, Key, Value, true)->
  parse_value(Rest, Parts, Key, <<Value/binary,"\\">>, true);

%%    end
parse_value(<<>>, Parts, Key, Value, false)->
  {ok, [{Key, Value}|Parts]};
parse_value(<<"\n">>, Parts, Key, Value, _)->
  {ok, [{Key, Value}|Parts]};
parse_value(<<" ",Rest/binary>>, Parts, Key, Value, false)->
  find_key(Rest, [{Key, Value}|Parts], <<>>, <<>>);
parse_value(<<"\"",Rest/binary>>, Parts, Key, Value, true)->
  find_key(Rest, [{Key, Value}|Parts], <<>>, <<>>);
parse_value(<<>>, Parts, _, _, _)->
  {ok, Parts};

%%    append
parse_value(<<C:1/binary,Rest/binary>>, Parts, Key, Value, HasQuotes)->
  parse_value(Rest, Parts, Key, <<Value/binary,C/binary>>, HasQuotes).
