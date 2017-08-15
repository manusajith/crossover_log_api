defmodule LogApi.Log.Events.OwnerCreated do
  @derive [Poison.Encoder]
  defstruct [
    :uuid,
    :application_uuid,
    :display_name,
  ]
end
