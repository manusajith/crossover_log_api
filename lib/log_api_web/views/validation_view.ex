defmodule LogApiWeb.ValidationView do
  use LogApiWeb, :view

  def render("error.json", %{errors: errors}) do
    %{errors: errors}
  end
end
