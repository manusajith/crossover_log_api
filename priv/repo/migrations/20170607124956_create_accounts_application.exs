defmodule LogApi.Repo.Migrations.CreateConduit.Accounts.Application do
  use Ecto.Migration

  def change do
    create table(:accounts_applications, primary_key: false) do
      add :uuid,     :uuid,    primary_key: true
      add :version,            :integer, default: 0
      add :display_name,       :string
      add :application_secret, :string

      timestamps()
    end

    create unique_index(:accounts_applications, [:display_name])
  end
end
