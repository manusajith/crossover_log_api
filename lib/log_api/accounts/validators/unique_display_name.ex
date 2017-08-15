defmodule LogApi.Accounts.Validators.UniqueDisplayName do
  use Vex.Validator

  alias LogApi.Accounts
  alias LogApi.Accounts.Application

  def validate(display_name, context) do
    application_uuid = Map.get(context, :display_name)

    case display_name_registered?(display_name, display_name) do
      true  -> {:error, "has already been taken"}
      false -> :ok
    end
  end

  defp display_name_registered?(display_name, application_uuid) do
    case Accounts.application_by_display_name(display_name) do
      %Application{uuid: ^application_uuid} -> false
      nil -> false
      _   -> true
    end
  end
end
