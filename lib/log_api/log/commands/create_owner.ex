defmodule LogApi.Log.Commands.CreateOwner do
  defstruct [
    uuid:             "",
    application_uuid: "",
    display_name:     "",
  ]

  use ExConstructor
  use Vex.Struct

  alias LogApi.Log.Commands.CreateOwner

  validates :uuid, uuid: true

  validates :application_uuid, uuid: true

  validates :display_name,
    presence: [message: "can't be empty"],
    format: [with: ~r/^[a-z0-9]+$/, allow_nil: true, allow_blank: true, message: "is invalid"],
    string: true

  @doc """
  Assign a unique identity
  """
  def assign_uuid(%CreateOwner{} = create_owner, uuid) do
    %CreateOwner{create_owner |
      uuid: uuid
    }
  end
end
