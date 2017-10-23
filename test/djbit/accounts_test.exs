defmodule DjBit.AccountsTest do
  use DjBit.DataCase, async: true

  import Mock
  import DjBit.Factory

  alias DjBit.Repo
  alias DjBit.Accounts
  alias DjBit.Accounts.Team

  setup do
    team = insert(:team)
    {:ok, team: team}
  end

  describe "create_user_from_slack/1" do
    test "creates a User associated with Team", %{team: team} do
      slack_team_identity = string_params_for(:slack_team_identity, id: team.slack_id)
      slack_user_identity = string_params_for(:slack_user_identity, team: slack_team_identity)

      with_mock DjBit.Slack, [exchange_for_user_identity: fn("valid_code") -> slack_user_identity end] do
        {:ok, user} = Accounts.create_user_from_oauth("valid_code")
        assert user.slack_id == slack_user_identity["user"]["id"]
        assert user.name == slack_user_identity["user"]["name"]
        assert user.team_id == team.id
      end
    end

    test "creates a Team if does not exist" do
      slack_user_identity = string_params_for(:slack_user_identity)

      with_mock DjBit.Slack, [exchange_for_user_identity: fn("valid_code") -> slack_user_identity end] do
        {:ok, user} = Accounts.create_user_from_oauth("valid_code")
        team = Repo.get_by(Team, slack_id: slack_user_identity["team"]["id"])
        assert user.team_id == team.id
      end
    end
  end

  describe "create_user_from_oauth/1" do
    test "creates a User associated with Team", %{team: team} do
      slack_team_identity = string_params_for(:slack_team_identity, id: team.slack_id)
      slack_user_identity = string_params_for(:slack_user_identity, team: slack_team_identity)

      with_mock DjBit.Slack, [exchange_for_user_identity: fn("valid_code") -> slack_user_identity end] do
        {:ok, _user} = Accounts.create_user_from_oauth("valid_code")
      end
    end
  end

  describe "create_user/1" do
    test "creates a User", %{team: team} do
      attrs = string_params_for(:user, team_id: team.id)
      assert {:ok, _user} = Accounts.create_user(attrs)
    end

    test "when slack_id nil, returns error changeset", %{team: team} do
      attrs = string_params_for(:user, team_id: team.id, slack_id: nil)
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(attrs)
    end

    test "when name nil, returns error changeset", %{team: team} do
      attrs = string_params_for(:user, team_id: team.id, name: nil)
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(attrs)
    end

    test "when team_id nil, returns error changeset" do
      attrs = string_params_for(:user, team_id: nil)
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(attrs)
    end

    test "when slack_id already assigned to Team, returns error changeset", %{team: team} do
      user = insert(:user, team_id: team.id)
      attrs = string_params_for(:user, slack_id: user.slack_id, team_id: team.id)
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(attrs)
    end
  end

  describe "create_team/1" do
    test "creates a Team" do
      attrs = string_params_for(:team)
      assert {:ok, _team} = Accounts.create_team(attrs)
    end

    test "when slack_id nil, returns error changeset" do
      attrs = string_params_for(:team, slack_id: nil)
      assert {:error, %Ecto.Changeset{}} = Accounts.create_team(attrs)
    end

    test "when slack_id already exists, returns error changeset", %{team: team} do
      attrs = string_params_for(:team, slack_id: team.slack_id)
      assert {:error, %Ecto.Changeset{}} = Accounts.create_team(attrs)
    end
  end
end
