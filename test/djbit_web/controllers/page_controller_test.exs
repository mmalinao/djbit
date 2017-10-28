defmodule DjBitWeb.PageControllerTest do
  use DjBitWeb.ConnCase

  describe "GET /" do
    test "renders Sign-in with Slack", %{conn: conn} do
      resp = conn |> get("/")
      assert html_response(resp, 200) =~ "Sign-in with Slack"
    end
  end
end
