defmodule LogApi.Auth.GuardianSerializer do
  @moduledoc """
  Used by Guardian to serialize a JWT token
  """

  @behaviour Guardian.Serializer

  alias LogApi.Accounts
  alias LogApi.Accounts.Application

  def for_token(%Application{} = application), do: {:ok, "Application:#{application.uuid}"}
  def for_token(_), do: {:error, "Unknown resource type"}

  def from_token("Application:" <> uuid), do: {:ok, Accounts.application_by_uuid(uuid)}
  def from_token(_), do: {:error, "Unknown resource type"}
end
