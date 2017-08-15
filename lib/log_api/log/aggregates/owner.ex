defmodule LogApi.Log.Aggregates.Owner do
  defstruct [
    uuid:             nil,
    application_uuid: nil,
    display_name:     nil,
  ]

  alias LogApi.Log.Aggregates.Owner
  alias LogApi.Log.Commands.CreateOwner
  alias LogApi.Log.Events.OwnerCreated

  @doc """
  Creates an application owner
  """
  def execute(%Owner{uuid: nil}, %CreateOwner{} = create) do
    %OwnerCreated{
      uuid:             create.uuid,
      application_uuid: create.application_uuid,
      display_name:     create.display_name,
    }
  end

  # state mutators

  def apply(%Owner{} = owner, %OwnerCreated{} = created) do
    %Owner{owner |
      uuid:             created.uuid,
      application_uuid: created.application_uuid,
      display_name:     created.display_name,
    }
  end
end
