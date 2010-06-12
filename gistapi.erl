-module(gistapi).
-export([get_gist/1]).

% BASE URL definitions
-define(BASE_API_URL, "http://gist.github.com/api/v1/").
-define(BASE_RAW_URL, "http://gist.github.com/raw/").

% functions to get the assembled URLs
get_gist_url(yaml, ID) ->
  ?BASE_API_URL ++ yaml ++ "/" ++ ID.

get_users_gists_url(yaml, Login) ->
  ?BASE_API_URL ++ yaml ++ "/gists/" ++ Login.

get_gist_content_url(ID, File) ->
  ?BASE_RAW_URL ++ ID ++ "/" ++ File.

% functions to make the actual requests
