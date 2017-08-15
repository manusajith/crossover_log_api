defmodule LogApi.Accounts.Projectors.Application do
  use Commanded.Projections.Ecto, name: "Accounts.Projectors.Application"

  alias LogApi.Accounts.Events.ApplicationRegistered
  alias LogApi.Accounts.Application
  alias LogApi.Accounts.Notifications

  project %ApplicationRegistered{} = registered, %{stream_version: version} do
    Ecto.Multi.insert(multi, :application, %Application{
      uuid:               registered.uuid,
      version:            version,
      display_name:       registered.display_name,
      application_secret: registered.application_secret,
    })
  end

  project %ApplicationReset{} = application, %{stream_version: version} do
    Ecto.Multi.insert(multi, :application, %Application{
      uuid:               registered.uuid,
      version:            version,
      application_secret: registered.application_secret,
    })
  end

  def after_update(_event, _metadata, changes), do: Notifications.publish_changes(changes)
end
