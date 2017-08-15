defmodule LogApi.Accounts.Events.ApplicationRegistered do
  @derive [Poison.Encoder]
  defstruct [
    :uuid,
    :display_name,
    :application_secret,
  ]
end
