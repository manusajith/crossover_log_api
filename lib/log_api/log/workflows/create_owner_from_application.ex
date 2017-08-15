defmodule LogApi.Log.Workflows.CreateOnwerFromApplication do
  use Commanded.Event.Handler, name: "Log.Workflows.CreateOnwerFromApplication"

  alias LogApi.Accounts.Events.ApplicationRegistered
  alias LogApi.Log

  def handle(%ApplicationRegistered{uuid: application_uuid, display_name: display_name}, _metadata) do
    {:ok, _owner} = Log.create_owner(%{application_uuid: application_uuid, display_name: display_name})

    :ok
  end
end
