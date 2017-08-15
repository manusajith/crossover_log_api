defmodule LogApiWeb.LogController do
  use LogApiWeb, :controller
  use Guardian.Phoenix.Controller

  alias LogApi.Log
  alias LogApi.Log.LogEntry
  alias LogApiWeb.RateLimiter

  plug Guardian.Plug.EnsureAuthenticated, %{handler: LogApiWeb.ErrorHandler} when action in [:create]
  plug Guardian.Plug.EnsureResource,      %{handler: LogApiWeb.ErrorHandler} when action in [:create]

  action_fallback LogApiWeb.FallbackController

  def create(conn, log_entry_params, application, _claims) do
    ip = conn.remote_ip
    |> Tuple.to_list
    |> Enum.join(".")
    case RateLimiter.check_rate("log:#{ip}", 60_000, 5) do
      {:allow, _count} ->
        log_owner = Log.get_owner!(application)
        with {:ok, %LogEntry{} = log} <- Log.record_log_entry(log_owner, log_entry_params) do
          conn
          |> put_status(:created)
          |> render("show.json", log: log)
        end
      {:deny, _} ->
        conn |> send_resp(403, "Application Rate Limit Exceeded")
    end
  end
end
