defmodule DjBitWeb.Router do
  use DjBitWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug Guardian.Plug.Pipeline, module: DjBitWeb.Guardian, error_handler: DjBitWeb.Guardian.ErrorHandler
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource, allow_blank: true
  end

  # pipeline :api do
  #   plug :accepts, ["json"]
  # end

  scope "/", DjBitWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/slack/callback", SessionController, :callback
  end
end
