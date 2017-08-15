defmodule LogApiWeb.ApplicationController do
  use LogApiWeb, :controller
  use Guardian.Phoenix.Controller

  alias LogApi.Accounts
  alias LogApi.Accounts.Application
  # alias LogApi.Log
  # alias LogApi.Log.Owner

  action_fallback LogApiWeb.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, %{handler: LogApiWeb.ErrorHandler} when action in [:current]
  plug Guardian.Plug.EnsureResource,      %{handler: LogApiWeb.ErrorHandler} when action in [:current]

  def create(conn, application_params, _application, _claims) do
    with {:ok, %Application{} = application} <- Accounts.register_application(application_params),
         {:ok, jwt} = generate_jwt(application) do
      conn
      |> put_status(:created)
      |> render("show.json", application: application, jwt: jwt)
    end
  end

  def reset_token(conn, _, _application, _claims) do
    jwt = Guardian.Plug.current_token(conn)
    with {:ok, %Application{} = application} <- Accounts.register_application,
         {:ok, jwt} = generate_jwt(application) do
      conn
        |> put_status(:created)
        |> render("show.json", application: application, jwt: jwt)
    end
  end

  def current(conn, _params, application, _claims) do
    jwt = Guardian.Plug.current_token(conn)

    conn
    |> put_status(:ok)
    |> render("show.json", application: application, jwt: jwt)
  end
end
