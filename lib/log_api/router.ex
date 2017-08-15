defmodule LogApi.Router do
  use Commanded.Commands.Router

  alias LogApi.Accounts.Aggregates.Application
  alias LogApi.Accounts.Commands.RegisterApplication

  alias LogApi.Log.Aggregates.{Log,Owner}
  alias LogApi.Log.Commands.{CreateOwner,RecordLogEntry}

  middleware LogApi.Validation.Middleware.Validate
  middleware LogApi.Validation.Middleware.Uniqueness

  dispatch [RecordLogEntry],      to: Log,         identity: :uuid
  dispatch [CreateOwner],         to: Owner,       identity: :uuid
  dispatch [RegisterApplication], to: Application, identity: :uuid
end
