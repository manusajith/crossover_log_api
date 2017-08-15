defmodule LogApi.Log.Commands.RecordLogEntry do
  defstruct [
    uuid:             nil,
    logger:           nil,
    level:            nil,
    message:          nil,
    application_uuid: nil,
  ]

  use ExConstructor
  use Vex.Struct

  alias LogApi.Log.Owner
  alias LogApi.Log.Commands.RecordLogEntry

  validates :uuid, uuid: true

  validates :logger, presence: [message: "can't be empty"], string: true

  validates :level, presence: [message: "can't be empty"], string: true

  validates :message, presence: [message: "can't be empty"], string: true

  validates :application_uuid, uuid: true

  @doc """
  Assign a unique identity
  """
  def assign_uuid(%RecordLogEntry{} = record_log_entry, uuid) do
    %RecordLogEntry{record_log_entry | uuid: uuid}
  end

  @doc """
  Assign the application owner
  """
  def assign_owner(%RecordLogEntry{} = record_log_entry, %Owner{uuid: uuid}) do
    %RecordLogEntry{record_log_entry | application_uuid: uuid}
  end
end
