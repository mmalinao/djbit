defmodule DjBitWeb.SessionController do
  use DjBitWeb, :controller
  alias DjBit.Accounts

  def callback(conn, %{"code" => code}) do
    {:ok, _user} = Accounts.create_user_from_oauth(code)
    text conn, "OK"
  end
end
