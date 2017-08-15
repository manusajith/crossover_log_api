defmodule LogApi.Log.Events.LogEntryRecorded do
  @derive [Poison.Encoder]
  defstruct [
    :uuid,
    :logger,
    :level,
    :message,
    :application_uuid,
  ]
end
