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
find_key(<<$\s,Rest/binary>>, Parts, <<>> = Key, <<>> = Value)->
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

%% JSON garbage
parse_key(<<${,_/binary>>,_,_,_)->
  {ok, []};
parse_key(<<$},_/binary>>,_,_,_)->
  {ok, []};
parse_key(<<$:,_/binary>>,_,_,_)->
  {ok, []};
parse_key(<<$",_/binary>>,_,_,_)->
  {ok, []};

parse_key(<<$=,Rest/binary>>, Parts, Key, Value)->
  start_value(Rest, Parts, Key, Value);

%% Adds another 20,000 msg/sec on 2Ghz i7 - I know it's ugly
%% becomes much slower when the key is longer than 32 bytes
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

%% It's probably garbage
parse_key(<<$\s,_/binary>>,_,_,_)->
  {ok, []};

%% append the character
parse_key(<<C:1/binary,Rest/binary>>, Parts, Key, Value)->
  parse_key(Rest, Parts, <<Key/binary,C/binary>>, Value).

%% Transition state
start_value(<<$",Rest/binary>>, Parts, Key, Value)->
  parse_quote_value(Rest, Parts, Key, Value);
start_value(Rest, Parts, Key, Value)->
  parse_value(Rest, Parts, Key, Value).

%% Value

%% Quotes
-spec parse_quote_value(binary(), [{binary(), binary()}], binary(), binary()) -> {ok, [{binary(), binary()}]}.
parse_quote_value(<<>>, Parts, _, _)->
  {ok, Parts};
parse_quote_value(<<"\\\"",Rest/binary>>, Parts, Key, Value)->
  parse_quote_value(Rest, Parts, Key, <<Value/binary,$">>);
parse_quote_value(<<"\\\\",Rest/binary>>, Parts, Key, Value)->
  parse_quote_value(Rest, Parts, Key, <<Value/binary,"\\">>);
parse_quote_value(<<$",$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, Value}|Parts], <<>>, <<>>);
parse_quote_value(<<$">>, Parts, Key, Value)->
  {ok, [{Key, Value}|Parts]};
parse_quote_value(<<$",Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, Value}|Parts], <<>>, <<>>);
parse_quote_value(<<C:1/binary,Rest/binary>>, Parts, Key, Value)->
  parse_quote_value(Rest, Parts, Key, <<Value/binary,C/binary>>).

%% No Quotes
-spec parse_value(binary(), [{binary(), binary()}], binary(), binary()) -> {ok, [{binary(), binary()}]}.

%% Adds another 30,000 msg/sec on 2Ghz i7
%% becomes much slower when the value is longer than 64 bytes
parse_value(<<$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, Value}|Parts], <<>>, <<>>);
parse_value(<<C:1/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:2/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:3/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:4/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:5/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:6/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:7/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:8/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:9/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:10/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:11/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:12/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:13/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:14/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:15/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:16/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:17/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:18/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:19/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:20/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:21/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:22/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:23/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:24/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:25/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:26/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:27/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:28/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:29/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:30/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:31/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:32/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:33/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:34/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:35/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:36/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:37/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:38/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:39/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:40/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:41/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:42/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:43/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:44/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:45/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:46/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:47/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:48/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:49/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:50/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:51/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:52/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:53/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:54/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:55/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:56/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:57/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:58/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:59/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:60/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:61/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:62/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:63/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:64/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);

%% EOS
parse_value(<<>>, Parts, Key, Value)->
  {ok, [{Key, Value}|Parts]};
parse_value(<<"\n">>, Parts, Key, Value)->
  {ok, [{Key, Value}|Parts]};

parse_value(<<C:1/binary,Rest/binary>>, Parts, Key, Value)->
  parse_value(Rest, Parts, Key, <<Value/binary,C/binary>>).
