defmodule DjBitWeb.SessionController do
  use DjBitWeb, :controller
  alias DjBit.Accounts
  alias DjBitWeb.Guardian

  def callback(conn, %{"code" => code}) do
    {:ok, user} = Accounts.create_user_from_oauth(code)

    conn
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: "/users/#{user.id}")
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> redirect(to: "/")
  end
end
