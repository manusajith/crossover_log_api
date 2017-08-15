defmodule LogApi.Log do
  @moduledoc """
  The boundary for the Log system.
  """

  alias LogApi.Accounts.Application
  alias LogApi.Log.{LogEntry,Owner}
  alias LogApi.Log.Commands.{CreateOwner,RecordLogEntry}
  alias LogApi.{Repo,Router,Wait}

  @doc """
  Get the owner for a given application account, or return `nil` if not found
  """
  def get_owner(application)
  def get_owner(nil), do: nil
  def get_owner(%Application{uuid: application_uuid}), do: Repo.get_by(Owner, application_uuid: application_uuid)

  @doc """
  Get the owner for a given application, or raise an `Ecto.NoResultsError` if not found
  """
  def get_owner!(%Application{uuid: application_uuid}), do: Repo.get_by!(Owner, application_uuid: application_uuid)

  @doc """
  Create an owner
  """
  def create_owner(attrs \\ %{}) do
    uuid = UUID.uuid4()

    attrs
    |> CreateOwner.new()
    |> CreateOwner.assign_uuid(uuid)
    |> Router.dispatch()
    |> case do
      :ok -> Wait.until(fn -> Repo.get(Owner, uuid) end)
      reply -> reply
    end
  end


  @doc """
  Publishes an log entry by the given owner.
  """
  def record_log_entry(%Owner{} = owner, attrs \\ %{}) do
    uuid = UUID.uuid4()

    attrs
    |> RecordLogEntry.new()
    |> RecordLogEntry.assign_uuid(uuid)
    |> RecordLogEntry.assign_owner(owner)
    |> Router.dispatch()
    |> case do
      :ok -> Wait.until(fn -> Repo.get(LogEntry, uuid) end)
      reply -> reply
    end
  end

end
