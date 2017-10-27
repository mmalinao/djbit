defmodule DjBitWeb.SessionController do
  use DjBitWeb, :controller
  alias DjBit.Accounts
  alias DjBitWeb.Guardian

  def callback(conn, %{"code" => code}) do
    {:ok, user} = Accounts.create_user_from_oauth(code)

    conn
    |> Guardian.Plug.sign_in(user)
    |> text("OK")
  end
end
