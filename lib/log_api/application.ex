defmodule LogApi.Application do
  use Application

  alias LogApi.{Accounts,Log}

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      # Start the Ecto repository
      supervisor(LogApi.Repo, []),

      # Start the endpoint when the application starts
      supervisor(LogApiWeb.Endpoint, []),

      # Accounts context
      supervisor(LogApi.Accounts.Supervisor, []),

      supervisor(LogApiWeb.RateLimiter, []),

      # Enforce unique constraints
      worker(LogApi.Validation.Unique, []),

      # Read model projections
      worker(Log.Projectors.Log, [], id: :log_entries_projector),

      # Workflows
      worker(Log.Workflows.CreateOnwerFromApplication, [], id: :create_owner_workflow),
    ]

    opts = [strategy: :one_for_one, name: LogApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LogApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
