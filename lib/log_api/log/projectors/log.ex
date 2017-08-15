defmodule LogApi.Log.Projectors.Log do
  use Commanded.Projections.Ecto, name: "Log.Projectors.Log"

  alias LogApi.Log.{Owner,LogEntry}
  alias LogApi.Log.Events.{
    LogEntryRecorded,
    OwnerCreated,
  }
  alias LogApi.Repo

  project %OwnerCreated{} = owner do
    Ecto.Multi.insert(multi, :owner, %Owner{
      uuid:             owner.uuid,
      application_uuid: owner.application_uuid,
      display_name:     owner.display_name,
    })
  end

  project %LogEntryRecorded{} = recorded, %{created_at: published_at} do
    multi
    |> Ecto.Multi.run(:owner, fn _changes -> get_owner(recorded.application_uuid) end)
    |> Ecto.Multi.run(:log, fn %{owner: owner} ->
      log = %LogEntry{
        uuid:                     recorded.uuid,
        logger:                   recorded.logger,
        level:                    recorded.level,
        message:                  recorded.message,
        application_uuid:         owner.uuid,
        application_display_name: owner.display_name,
      }
      Repo.insert(log)
    end)
  end

  defp get_owner(uuid) do
    case Repo.get(Owner, uuid) do
      nil   -> {:error, :owner_not_found}
      owner -> {:ok, owner}
    end
  end
end
