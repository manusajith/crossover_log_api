defmodule LogApi.Accounts do
  @moduledoc """
  The boundary for the Accounts system.
  """

  alias LogApi.Accounts.Commands.RegisterApplication
  alias LogApi.Accounts.Notifications
  alias LogApi.Accounts.Queries.ApplicationByDisplayName
  alias LogApi.Accounts.Application
  alias LogApi.{Repo,Router}

  @doc """
  Register a new Application.
  """
  def register_application(attrs \\ %{}) do
    application_uuid = UUID.uuid4()
    register_application =
      attrs
      |> RegisterApplication.new()
      |> RegisterApplication.assign_uuid(application_uuid)
      |> RegisterApplication.downcase_display_name()
      |> RegisterApplication.hash_password()

    with {:ok, version} <- Router.dispatch(register_application, include_aggregate_version: true) do
      Notifications.wait_for(Application, application_uuid, version)
    else
      reply -> reply
    end
  end

  @doc """
  Get an existing Application by their display name, or return `nil` if not registered
  """
  def application_by_display_name(display_name) when is_binary(display_name) do
    display_name
    |> String.downcase()
    |> ApplicationByDisplayName.new()
    |> Repo.one()
  end


  @doc """
  Get a single application by their UUID
  """
  def application_by_uuid(uuid) when is_binary(uuid) do
    Repo.get(Application, uuid)
  end
end
