defmodule LogApiWeb.SessionController do
  use LogApiWeb, :controller

  alias LogApi.Auth
  alias LogApi.Accounts.Application

  action_fallback LogApiWeb.FallbackController

  def create(conn, %{"application" => %{"display_name" => display_name, "password" => password}}) do
    with {:ok, %Application{} = application} <- Auth.authenticate(display_name, password),
         {:ok, jwt} <- generate_jwt(application) do
       conn
        |> put_status(:created)
        |> render(LogApiWeb.ApplicationView, "show.json", application: application, jwt: jwt)
    else
      {:error, :unauthenticated} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LogApiWeb.ValidationView, "error.json", errors: %{"display_name or password" => ["is invalid"]})
    end
  end
end
