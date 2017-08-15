defmodule LogApiWeb.ApplicationView do
  use LogApiWeb, :view
  alias LogApiWeb.ApplicationView

  def render("index.json", %{applications: applications}) do
    %{applications: render_many(applications, ApplicationView, "application.json")}
  end

  def render("show.json", %{application: application, jwt: jwt}) do
    %{application: application |> render_one(ApplicationView, "application.json") |> Map.merge(%{token: jwt})}
  end

  def render("application.json", %{application: application}) do
    %{
      application_id: application.uuid,
      display_name: application.display_name
    }
  end
end
