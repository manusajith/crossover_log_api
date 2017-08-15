defmodule LogApiWeb.Router do
  use LogApiWeb, :router

  alias LogApiWeb.Plugs

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Application"
    plug Guardian.Plug.LoadResource
  end

  scope "/api", LogApiWeb do
    pipe_through :api

    post "/log", LogController, :create

    get "/application",         ApplicationController, :current
    post "/applications/login", SessionController,     :create
    post "/register",           ApplicationController, :create
    post "/applications/reset", ApplicationController, :reset_token
  end
end
