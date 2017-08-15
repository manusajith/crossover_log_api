defmodule LogApi.Factory do
  use ExMachina

  alias LogApi.Accounts.Commands.RegisterApplication
  alias LogApi.Log.Commands.RecordLogEntry

  def log_entry_factory do
    %{
      logger:           "com.logger.service.Uploader",
      level:            "Error",
      message:          "The communication pipeline is broken",
      application_uuid: UUID.uuid4(),
    }
  end

  def owner_factory do
    %{
      owner_uuid:    UUID.uuid4(),
      display_name: "crossover",
    }
  end

  def application_factory do
    %{
      display_name:       "crossover",
      password:           "sekret",
      application_sekret: "sekret",
    }
  end

  def register_log_entry_factory do
    struct(RecordLogEntry, build(:log))
  end

  def register_application_factory do
    struct(RegisterApplication, build(:application))
  end
end
