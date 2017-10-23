defmodule DjBit.Accounts do
  import Ecto.Query, warn: false
  alias DjBit.Repo
  alias DjBit.Accounts.{User, Team}

  def create_user_from_oauth(code) do
    data = code
    |> DjBit.Slack.exchange_for_user_identity

    {:ok, team} = create_team_from_slack(data)
    {:ok, _user} = create_user_from_slack(data, team.id)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  defp create_user_from_slack(%{"user" => user_attrs}, team_id) do
    attrs = %{slack_id: user_attrs["id"], name: user_attrs["name"], img_url: user_attrs["image_32"], team_id: team_id}

    case Repo.get_by(User, slack_id: attrs[:slack_id]) do
      nil ->
        create_user(attrs)
      user ->
        {:ok, user}
    end
  end

  defp create_team_from_slack(%{"team" => team_attrs}) do
    attrs = %{slack_id: team_attrs["id"], name: team_attrs["name"], img_url: team_attrs["image_34"]}

    case Repo.get_by(Team, slack_id: attrs[:slack_id]) do
      nil ->
        create_team(attrs)
      team ->
        {:ok, team}
    end
  end
end
