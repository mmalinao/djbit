defmodule DjBitWeb.UserController do
  use DjBitWeb, :controller
  alias DjBit.Accounts

  action_fallback DjBitWeb.FallbackController

  def show(conn, _params) do
    render conn, "show.html"
  end
end
