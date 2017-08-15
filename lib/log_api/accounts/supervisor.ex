defmodule LogApi.Accounts.Supervisor do
  use Supervisor

  alias LogApi.Accounts

  def start_link do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    children = [
      supervisor(Registry, [:duplicate, Accounts]),

      # Read model projections
      worker(Accounts.Projectors.Application, [], id: :accounts_applications_projector),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
