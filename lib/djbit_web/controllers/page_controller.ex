defmodule DjBitWeb.PageController do
  use DjBitWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
