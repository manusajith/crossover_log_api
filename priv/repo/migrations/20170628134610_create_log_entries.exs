defmodule LogApi.Repo.Migrations.CreateConduit.Log.LogEntry do
  use Ecto.Migration

  def change do
    create table(:log_entries, primary_key: false) do
      add :uuid,    :uuid,   primary_key: true
      add :logger,  :string, size: 256
      add :level,   :string, size: 256
      add :message, :text

      add :application_uuid,         :uuid
      add :application_display_name, :string

      timestamps()
    end

    create index(:log_entries, [:application_uuid])
    create index(:log_entries, [:application_display_name])
  end
end
