defmodule LogApiWeb.RateLimiter do
  use Supervisor

  use Hammer, backend: Hammer.Backend.ETS

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(Hammer.Backend.ETS, [[expiry_ms: 1000 * 60 * 10,
                                   cleanup_rate_ms: 1000 * 60 * 2]]),
    ]
    supervise(children, strategy: :one_for_one, name: LogApiWeb.RateLimiter)
  end
end
