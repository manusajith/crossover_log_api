defmodule LogApi.Accounts.Events.ApplicationReset do
  @derive [Poison.Encoder]
  defstruct [
    :uuid,
    :application_secret,
  ]
end
