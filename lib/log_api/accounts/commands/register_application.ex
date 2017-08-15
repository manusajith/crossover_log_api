defmodule LogApi.Accounts.Commands.RegisterApplication do
  defstruct [
    uuid:               "",
    display_name:       "",
    password:           "",
    application_secret: "",
  ]

  use ExConstructor
  use Vex.Struct

  alias LogApi.Accounts.Commands.RegisterApplication
  alias LogApi.Accounts.Validators.UniqueDisplayName
  alias LogApi.Auth

  validates :uuid, uuid: true

  validates :display_name,
    presence: [message: "can't be empty"],
    format: [with: ~r/^[a-z0-9]+$/, allow_nil: true, allow_blank: true, message: "is invalid"],
    string: true,
    by: &UniqueDisplayName.validate/2

  validates :application_secret, presence: [message: "can't be empty"], string: true

  @doc """
  Assign a unique identity
  """
  def assign_uuid(%RegisterApplication{} = register_application, uuid) do
    %RegisterApplication{register_application | uuid: uuid}
  end

  @doc """
  Convert display_name to lowercase characters
  """
  def downcase_display_name(%RegisterApplication{display_name: display_name} = register_application) do
    %RegisterApplication{register_application | display_name: String.downcase(display_name)}
  end

  @doc """
  Hash the password, clear the original password
  """
  def hash_password(%RegisterApplication{password: password} = register_application) do
    %RegisterApplication{register_application |
      password: nil,
      application_secret: Auth.hash_password(password),
    }
  end

  def reset_token(%ApplicationReset{} = application) do
    %ApplicationReset{application |
      password: nil,
      application_secret: Auth.hash_password,
    }
  end
end

defimpl LogApi.Validation.Middleware.Uniqueness.UniqueFields, for: LogApi.Accounts.Commands.RegisterApplication do
  def unique(%LogApi.Accounts.Commands.RegisterApplication{uuid: uuid}), do: [
    {:display_name, "has already been taken", uuid}
  ]
end
