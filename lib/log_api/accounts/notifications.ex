defmodule LogApi.Accounts.Notifications do
  alias LogApi.Accounts.Application
  alias LogApi.Repo

  @doc """
  Wait until the given read model is updated to the given version
  """
  def wait_for(schema, uuid, version) do
    case Repo.get_by(schema, uuid: uuid, version: version) do
      nil -> subscribe_and_wait(schema, uuid, version)
      projection -> {:ok, projection}
    end
  end

  @doc """
  Publish updated application read model to interested subscribers
  """
  def publish_changes(%{application: %Application{} = application}), do: publish(application)
  def publish_changes(%{application: {_, applications}}) when is_list(applications), do: Enum.each(applications, &publish/1)
  def publish_changes(_changes), do: :ok

  defp publish(%Application{uuid: uuid, version: version} = application) do
    Registry.dispatch(LogApi.Accounts, {Application, uuid, version}, fn entries ->
      for {pid, _} <- entries, do: send(pid, {Application, application})
    end)
  end

  # Subscribe to notifications of read model updates and wait for the expected version
  defp subscribe_and_wait(schema, uuid, version) do
    Registry.register(LogApi.Accounts, {schema, uuid, version}, [])

    receive do
      {^schema, projection} -> {:ok, projection}
    after
      5_000 -> {:error, :timeout}
    end
  end
end
