%%
%% syslog_message_keyvalue.erl
%%
-module (syslog_message_keyvalue).

-export([parse/1]).

%% @doc Parse a 'key=value' formatted message
%% @public
-spec parse(binary()) -> {ok, [{binary(), binary()}]}.
parse(Message)->
  find_key(Message, [], <<>>, <<>>, false).


%% @doc Find a key
%% @private
-spec find_key(binary(), [{binary(), binary()}], binary(), binary(), boolean()) -> {ok, [{binary(), binary()}]}.
find_key(<<" ",Rest/binary>>, Parts, <<>> = Key, <<>> = Value, false)->
  find_key(Rest, Parts, Key, Value, false);
find_key(<<$",C:1/binary,Rest/binary>>, Parts, _, Value, false)->
  parse_key(Rest, Parts, C, Value, true);
find_key(<<C:1/binary,Rest/binary>>, Parts, _, Value, false)->
  parse_key(Rest, Parts, C, Value, false);
find_key(<<>>, Parts, _, _, _)->
  {ok, Parts}.

%% Key

%%    end
-spec parse_key(binary(), [{binary(), binary()}], binary(), binary(), boolean()) -> {ok, [{binary(), binary()}]}.
parse_key(<<$",$=,Rest/binary>>, Parts, Key, Value, true)->
  parse_value(Rest, Parts, Key, Value, false);
parse_key(<<$",$=,$",Rest/binary>>, Parts, Key, Value, true)->
  parse_value(Rest, Parts, Key, Value, true);
parse_key(<<$=,$",Rest/binary>>, Parts, Key, Value, false)->
  parse_value(Rest, Parts, Key, Value, true);
parse_key(<<$=,Rest/binary>>, Parts, Key, Value, false)->
  parse_value(Rest, Parts, Key, Value, false);
parse_key(<<>>, Parts, _, _, _)->
  {ok, Parts};

%%    append
parse_key(<<C:1/binary,Rest/binary>>, Parts, Key, Value, HasQuotes)->
  parse_key(Rest, Parts, <<Key/binary,C/binary>>, Value, HasQuotes).

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
  find_key(Rest, [{Key, Value}|Parts], <<>>, <<>>, false);
parse_value(<<"\"",Rest/binary>>, Parts, Key, Value, true)->
  find_key(Rest, [{Key, Value}|Parts], <<>>, <<>>, false);
parse_value(<<>>, Parts, _, _, _)->
  {ok, Parts};

%%    append
parse_value(<<C:1/binary,Rest/binary>>, Parts, Key, Value, HasQuotes)->
  parse_value(Rest, Parts, Key, <<Value/binary,C/binary>>, HasQuotes).
