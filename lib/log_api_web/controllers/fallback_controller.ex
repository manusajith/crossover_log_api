defmodule LogApiWeb.FallbackController do
  use LogApiWeb, :controller

  def call(conn,  {:error, :validation_failure, errors}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(LogApiWeb.ValidationView, "error.json", errors: errors)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(LogApiWeb.ErrorView, :"404")
  end

  def call(conn, {:error, :timeout}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(LogApiWeb.ErrorView, :"404")
  end
end
