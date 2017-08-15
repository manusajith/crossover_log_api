defmodule LogApi.Accounts.Aggregates.Application do
  defstruct [
    :uuid,
    :display_name,
    :application_secret,
  ]

  alias LogApi.Accounts.Aggregates.Application
  alias LogApi.Accounts.Commands.RegisterApplication
  alias LogApi.Accounts.Events.ApplicationRegistered
  alias LogApi.Accounts.Events.ApplicationReset

  @doc """
  Register a new application
  """
  def execute(%Application{uuid: nil}, %RegisterApplication{} = register) do
    %ApplicationRegistered{
      uuid:               register.uuid,
      display_name:       register.display_name,
      application_secret: register.application_secret,
    }
  end
  def execute(%Application{uuid: nil}, %ApplicationReset{} = reset) do
    %ApplicationReset{
      uuid:               reset.uuid,
      application_secret: reset.application_secret,
    }
  end

  # state mutators

  def apply(%Application{} = application, %ApplicationRegistered{} = registered) do
    %Application{application |
      uuid:               registered.uuid,
      display_name:       registered.display_name,
      application_secret: registered.application_secret,
    }
  end
end
