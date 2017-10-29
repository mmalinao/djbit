defmodule DjBitWeb.UserController do
  use DjBitWeb, :controller
  alias DjBit.Accounts

  def show(conn, _params) do
    render conn, "show.html"
  end
end
