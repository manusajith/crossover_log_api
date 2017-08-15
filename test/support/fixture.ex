defmodule LogApi.Fixture do
  import LogApi.Factory

  alias LogApi.{Accounts,Log}
  alias LogApi.Log.Owner
  alias LogApi.{Repo,Wait}

  def register_application(_context) do
    {:ok, application} = fixture(:application)

    [
      application: application,
    ]
  end

  def create_owner(%{application: application}) do
    {:ok, owner} = fixture(:owner, application_uuid: application.uuid)

    [
      owner: owner,
    ]
  end

  def create_owner(_context) do
    {:ok, owner} = fixture(:owner, application_uuid: UUID.uuid4())

    [
      owner: owner,
    ]
  end

  def record_log_entry(%{owner: owner}) do
    {:ok, log_entry} = fixture(:log_entry, owner: owner)

    [
      log_entry: log_entry,
    ]
  end

  def fixture(resource, attrs \\ [])

  def fixture(:owner, attrs) do
    build(:owner, attrs) |> Log.create_owner()
  end

  def fixture(:application, attrs) do
    build(:application, attrs) |> Accounts.register_application()
  end

  def fixture(:log_entry, attrs) do
    {owner, attrs} = Keyword.pop(attrs, :owner)

    Log.record_log_entry(owner, build(:log_entry, attrs))
  end
end
