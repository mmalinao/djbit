defmodule DjBit.Slack do
  use HTTPoison.Base

  @headers [{"Content-Type", "application/x-www-form-urlencoded"}]

  def exchange_for_user_identity(code) do
    %{"ok" => true, "access_token" => token } = Slack.Web.Oauth.access(System.get_env("SLACK_CLIENT_ID"), System.get_env("SLACK_CLIENT_SECRET"), code)
    user_identity(token)
  end

  def user_identity(token) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = post("/users.identity", "token=#{token}", @headers)

    case body do
      %{"ok" => true} ->
        body
      %{"ok" => false, "error" => error} ->
        error
    end
  end

  ## HTTPoison Extensions

  def process_url(url), do: "https://slack.com/api" <> url
  def process_response_body(body), do: body |> Poison.decode!
end
