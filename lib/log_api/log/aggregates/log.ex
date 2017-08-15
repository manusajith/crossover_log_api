defmodule LogApi.Log.Aggregates.Log do
  defstruct [
    uuid:             nil,
    logger:           nil,
    level:            nil,
    message:          nil,
    application_uuid: nil,
  ]

  alias LogApi.Log.Aggregates.Log

  alias LogApi.Log.Commands.RecordLogEntry

  alias LogApi.Log.Events.LogEntryRecorded

  @doc """
  Record a log entry
  """
  def execute(%Log{uuid: nil}, %RecordLogEntry{} = record_log_entry) do
    %LogEntryRecorded{
      uuid:             record_log_entry.uuid,
      logger:           record_log_entry.logger,
      level:            record_log_entry.level,
      message:          record_log_entry.message,
      application_uuid: record_log_entry.application_uuid,
    }
  end

  # state mutators

  def apply(%Log{} = log, %LogEntryRecorded{} = log_entry) do
    %Log{log |
      uuid:             log_entry.uuid,
      logger:           log_entry.logger,
      level:            log_entry.level,
      message:          log_entry.message,
      application_uuid: log_entry.application_uuid,
    }
  end
end
