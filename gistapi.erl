-module(gistapi).
-export([get_gist/1]).

% defines
-define(BASE_API_URL, "http://gist.github.com/api/v1/").
-define(BASE_RAW_URL, "http://gist.github.com/raw/").
-define(GITHUB, "github.com").

% functions to make the actual requests

get_gist(Gist) ->
  if
    is_integer(Gist) ->
      ID = integer_to_list(Gist);
    is_list(Gist) ->
      ID = Gist
  end,
  Url = get_gist_url(yaml, ID),
  Response = http_get(Url),
  Response.

% helper functions
http_get(Url) ->
  inets:start(),
  case http:request(get, {Url, []}, [], []) of
        {ok, {{_, 200, _}, _, Body}} ->
          Response = Body;
        {ok, {{_, 403, _}, _, _}} ->
          Response = forbidden;
        {ok, {{_, 404, _}, _, _}} ->
          Response = not_found;
        {ok, _} ->
          Response = request_failed;
        {error, Reason} ->
          io:format("timeout? ~p~n", [Reason]),
          Response = Reason
  end,
  inets:stop(),
  Response.

% functions to get the assembled URLs
get_gist_url(yaml, ID) ->
  ?BASE_API_URL ++ "yaml/" ++ ID.

get_users_gists_url(yaml, Login) ->
  ?BASE_API_URL ++ "yaml/gists/" ++ Login.

get_gist_content_url(ID, File) ->
  ?BASE_RAW_URL ++ ID ++ "/" ++ File.


