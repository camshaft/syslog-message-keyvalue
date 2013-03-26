%%
%% syslog_message_keyvalue.erl
%%
-module (syslog_message_keyvalue).

-export([parse/1]).

%% @doc Parse a 'key=value' formatted message
%% @public
-spec parse(binary()) -> {ok, [{binary(), binary()}]}.
parse(Message)->
  parse_message(Message, [], <<>>, <<>>, unknown, false).

%% Unknown
parse_message(<<" ",Rest/binary>>, Parts, <<>> = Key, <<>> = Value, unknown, false)->
  parse_message(Rest, Parts, Key, Value, unknown, false);
parse_message(<<$",C:1/binary,Rest/binary>>, Parts, _, Value, unknown, false)->
  parse_message(Rest, Parts, C, Value, key, true);
parse_message(<<C:1/binary,Rest/binary>>, Parts, _, Value, unknown, false)->
  parse_message(Rest, Parts, C, Value, key, false);

%% Key

%%    end
parse_message(<<$",$=,Rest/binary>>, Parts, Key, Value, key, true)->
  parse_message(Rest, Parts, Key, Value, value, false);
parse_message(<<$",$=,$",Rest/binary>>, Parts, Key, Value, key, true)->
  parse_message(Rest, Parts, Key, Value, value, true);
parse_message(<<$=,$",Rest/binary>>, Parts, Key, Value, key, false)->
  parse_message(Rest, Parts, Key, Value, value, true);
parse_message(<<$=,Rest/binary>>, Parts, Key, Value, key, false)->
  parse_message(Rest, Parts, Key, Value, value, false);

%%    append
parse_message(<<C:1/binary,Rest/binary>>, Parts, Key, Value, key, HasQuotes)->
  parse_message(Rest, Parts, <<Key/binary,C/binary>>, Value, key, HasQuotes);

%% Value
parse_message(<<"\\\"",Rest/binary>>, Parts, Key, Value, value, true)->
  parse_message(Rest, Parts, Key, <<Value/binary,$">>, value, true);
parse_message(<<"\\\\",Rest/binary>>, Parts, Key, Value, value, true)->
  parse_message(Rest, Parts, Key, <<Value/binary,"\\">>, value, true);

%%    end
parse_message(<<>>, Parts, Key, Value, value, false)->
  {ok, [{Key, Value}|Parts]};
parse_message(<<"\n">>, Parts, Key, Value, value, _)->
  {ok, [{Key, Value}|Parts]};
parse_message(<<" ",Rest/binary>>, Parts, Key, Value, value, false)->
  parse_message(Rest, [{Key, Value}|Parts], <<>>, <<>>, unknown, false);
parse_message(<<"\"",Rest/binary>>, Parts, Key, Value, value, true)->
  parse_message(Rest, [{Key, Value}|Parts], <<>>, <<>>, unknown, false);

%%    append
parse_message(<<C:1/binary,Rest/binary>>, Parts, Key, Value, value, HasQuotes)->
  parse_message(Rest, Parts, Key, <<Value/binary,C/binary>>, value, HasQuotes);

%% Ended midstream
parse_message(<<>>, Parts, _, _, _, _)->
  {ok, Parts}.
