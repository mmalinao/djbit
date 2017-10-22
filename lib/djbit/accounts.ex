defmodule DjBit.Accounts do
  import Ecto.Query, warn: false
  alias DjBit.Repo
  alias DjBit.Accounts.User

  def create_user_from_slack(code) do
    data = Slack.Web.Oauth.access(System.get_env("SLACK_CLIENT_ID"), System.get_env("SLACK_CLIENT_SECRET"), code)

    %{slack_id: data["user"]["id"], name: data["user"]["name"]}
    |> create_user
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
