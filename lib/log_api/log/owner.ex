defmodule LogApi.Log.Owner do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "log_owners" do
    field :application_uuid, :binary_id
    field :display_name, :string

    timestamps()
  end
end
