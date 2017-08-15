defmodule LogApi.Repo.Migrations.CreateConduit.Log.Owner do
  use Ecto.Migration

  def change do
    create table(:log_owners, primary_key: false) do
      add :uuid,             :uuid, primary_key: true
      add :application_uuid, :uuid
      add :display_name,     :string

      timestamps()
    end

    create unique_index(:log_owners, [:application_uuid])
  end
end
