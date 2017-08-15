defmodule LogApi.Auth do
  @moduledoc """
  Boundary for authentication.
  Uses the bcrypt password hashing function.
  """

  alias Comeonin.Bcrypt

  alias LogApi.Accounts
  alias LogApi.Accounts.Application

  def authenticate(display_name, password) do
    with {:ok, application} <- application_by_display_name(display_name) do
      check_password(application, password)
   else
     reply -> reply
   end
  end

  def hash_password(password), do: Bcrypt.hashpwsalt(password)
  def validate_password(password, hash), do: Bcrypt.checkpw(password, hash)

  defp application_by_display_name(display_name) do
    case Accounts.application_by_display_name(display_name) do
      nil         -> {:error, :unauthenticated}
      application -> {:ok, application}
    end
  end

  defp check_password(%Application{application_secret: application_secret} = application, password) do
    case validate_password(password, application_secret) do
      true -> {:ok, application}
      _    -> {:error, :unauthenticated}
    end
  end
end
