defmodule DjBitWeb.UserControllerTest do
  use DjBitWeb.ConnCase
  import DjBit.Factory
  alias DjBitWeb.Guardian

  setup %{conn: conn} do
    user = insert(:user)
    new_conn = conn
    |> Guardian.Plug.sign_in(user)

    {:ok, conn: new_conn, user: user}
  end

  describe "GET /users/:id" do
    test "returns 200", %{conn: conn, user: user} do
      resp = conn
      |> get("/users/#{user.id}")

      assert resp.status == 200
    end
  end
end
