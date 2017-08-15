defmodule LogApiWeb.LogView do
  use LogApiWeb, :view
  alias LogApiWeb.LogView

  def render("show.json", %{log: log}) do
    %{log: render_one(log, LogView, "log.json")}
  end

  def render("log.json", %{log: log}) do
    %{
      application_id: log.application_uuid,
      logger:         log.logger,
      level:          log.level,
      message:        log.message
    }
  end
end
