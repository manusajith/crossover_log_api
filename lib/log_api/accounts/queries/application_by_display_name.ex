defmodule LogApi.Accounts.Queries.ApplicationByDisplayName do
  import Ecto.Query

  alias LogApi.Accounts.Application

  def new(display_name) do
    from u in Application,
    where: u.display_name == ^display_name
  end
end
