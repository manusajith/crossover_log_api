defmodule LogApi.Log.LogEntry do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "log_entries" do
    field :logger,                   :string
    field :level,                    :string
    field :message,                  :string
    field :application_uuid,         :binary_id
    field :application_display_name, :string

    timestamps()
  end
end
