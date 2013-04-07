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

%% eos
parse_value(<<>>, Parts, Key, Value)->
  {ok, [{Key, Value}|Parts]};
parse_value(<<"\n">>, Parts, Key, Value)->
  {ok, [{Key, Value}|Parts]};

%% Adds another 60,000 msg/sec on 2Ghz i7
%% becomes much slower when the value is longer than 128 bytes
parse_value(<<$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, Value}|Parts], <<>>, <<>>);
parse_value(<<$\s>>, Parts, Key, Value)->
  {ok, [{Key, Value}|Parts]};
parse_value(<<C:1/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:1/binary>>, Parts, Key, Value)->
  {ok, [{Key, <<Value/binary,C/binary>>}|Parts]};
parse_value(<<C:2/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:2/binary>>, Parts, Key, Value)->
  {ok, [{Key, <<Value/binary,C/binary>>}|Parts]};
parse_value(<<C:3/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:3/binary>>, Parts, Key, Value)->
  {ok, [{Key, <<Value/binary,C/binary>>}|Parts]};
parse_value(<<C:4/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:4/binary>>, Parts, Key, Value)->
  {ok, [{Key, <<Value/binary,C/binary>>}|Parts]};
parse_value(<<C:5/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:5/binary>>, Parts, Key, Value)->
  {ok, [{Key, <<Value/binary,C/binary>>}|Parts]};
parse_value(<<C:6/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:6/binary>>, Parts, Key, Value)->
  {ok, [{Key, <<Value/binary,C/binary>>}|Parts]};
parse_value(<<C:7/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:7/binary>>, Parts, Key, Value)->
  {ok, [{Key, <<Value/binary,C/binary>>}|Parts]};
parse_value(<<C:8/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:8/binary>>, Parts, Key, Value)->
  {ok, [{Key, <<Value/binary,C/binary>>}|Parts]};
parse_value(<<C:9/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:9/binary>>, Parts, Key, Value)->
  {ok, [{Key, <<Value/binary,C/binary>>}|Parts]};

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
parse_value(<<C:65/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:66/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:67/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:68/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:69/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);

parse_value(<<C:70/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:71/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:72/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:73/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:74/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:75/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:76/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:77/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:78/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:79/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);

parse_value(<<C:80/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:81/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:82/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:83/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:84/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:85/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:86/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:87/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:88/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:89/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);

parse_value(<<C:90/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:91/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:92/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:93/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:94/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:95/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:96/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:97/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:98/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:99/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);

parse_value(<<C:100/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:101/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:102/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:103/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:104/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:105/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:106/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:107/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:108/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:109/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);

parse_value(<<C:110/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:111/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:112/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:113/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:114/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:115/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:116/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:117/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:118/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:119/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);

parse_value(<<C:120/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:121/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:122/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:123/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:124/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:125/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:126/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:127/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);
parse_value(<<C:128/binary,$\s,Rest/binary>>, Parts, Key, Value)->
  find_key(Rest, [{Key, <<Value/binary,C/binary>>}|Parts], <<>>, <<>>);

%% append
parse_value(<<C:1/binary,Rest/binary>>, Parts, Key, Value)->
  parse_value(Rest, Parts, Key, <<Value/binary,C/binary>>).
