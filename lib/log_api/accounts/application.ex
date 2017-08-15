defmodule LogApi.Accounts.Application do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "accounts_applications" do
    field :version,            :integer, default: 0
    field :display_name,       :string,  unique: true
    field :application_secret, :string

    timestamps()
  end
end
