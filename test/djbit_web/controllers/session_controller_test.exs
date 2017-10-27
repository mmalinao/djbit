defmodule DjBitWeb.SessionControllerTest do
  use DjBitWeb.ConnCase

  import Mock
  import DjBit.Factory

  alias DjBit.Repo
  alias DjBit.Accounts.User
  alias DjBitWeb.Guardian

  describe "GET /slack/callback" do
    test "creates a User", %{conn: conn} do
      slack_user_identity = string_params_for(:slack_user_identity)

      refute Repo.get_by(User, slack_id: slack_user_identity["user"]["id"])

      with_mock DjBit.Slack, [exchange_for_user_identity: fn("valid_code") -> slack_user_identity end] do
        conn |> get("/slack/callback", %{"code" => "valid_code"})
      end

      assert Repo.get_by(User, slack_id: slack_user_identity["user"]["id"])
    end

    test "signs in user", %{conn: conn} do
      slack_user_identity = string_params_for(:slack_user_identity)

      with_mock DjBit.Slack, [exchange_for_user_identity: fn("valid_code") -> slack_user_identity end] do
        resp = conn
        |> get("/slack/callback", %{"code" => "valid_code"})

        assert Guardian.Plug.authenticated?(resp)
        assert Guardian.Plug.current_resource(resp).slack_id == slack_user_identity["user"]["id"]
      end
    end
  end
end
