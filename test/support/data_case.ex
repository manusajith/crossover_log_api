defmodule LogApi.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias LogApi.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import LogApi.Factory
      import LogApi.Fixture
      import LogApi.DataCase
    end
  end

  setup _tags do
    LogApi.Storage.reset!()
    
    :ok
  end
end
