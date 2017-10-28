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

    test "signs in user and redirects to user show", %{conn: conn} do
      slack_user_identity = string_params_for(:slack_user_identity)

      with_mock DjBit.Slack, [exchange_for_user_identity: fn("valid_code") -> slack_user_identity end] do
        resp = conn
        |> get("/slack/callback", %{"code" => "valid_code"})

        assert Guardian.Plug.authenticated?(resp)

        current_user = Guardian.Plug.current_resource(resp)

        assert current_user.slack_id == slack_user_identity["user"]["id"]
        assert redirected_to(resp) =~ "/users/#{current_user.id}"
      end
    end
  end

  describe "DELETE /sign_out" do
    test "signs out user and redirects to root", %{conn: conn} do
      user = insert(:user)

      resp = conn
      |> Guardian.Plug.sign_in(user)
      |> delete("/sign_out")

      refute Guardian.Plug.authenticated?(resp)
      assert redirected_to(resp) == "/"
    end
  end
end
