defmodule DjBit.AccountsTest do
  use DjBit.DataCase

  import Mock
  import DjBit.Factory

  alias DjBit.Accounts

  describe "create_user_from_slack/1" do
    test "creates a User given valid slack code" do
      slack_resp = string_params_for(:slack_token_exchange)

      with_mock Slack.Web.Oauth, [access: fn(_client_id, _client_secret, "valid_code") -> slack_resp end] do
        {:ok, user} = Accounts.create_user_from_slack("valid_code")
        assert user.slack_id == slack_resp["user"]["id"]
        assert user.name == slack_resp["user"]["name"]
      end
    end
  end

  describe "create_user/1" do
    test "creates a User" do
      attrs = string_params_for(:user)
      assert {:ok, _user} = Accounts.create_user(attrs)
    end

    test "with invalid attrs returns error changeset" do
      attrs = string_params_for(:user, slack_id: nil)
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(attrs)
    end
  end
end
