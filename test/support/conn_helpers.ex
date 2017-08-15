defmodule LogApiWeb.ConnHelpers do
  import Plug.Conn
  import LogApi.Fixture

  alias LogApi.Log.Owner
  alias LogApi.{Repo,Wait}

  def authenticated_conn(conn) do
    with {:ok, application} <- fixture(:application),
         {:ok, _owner}      <- get_owner(application)
    do
      authenticated_conn(conn, application)
    end
  end

  def authenticated_conn(conn, application) do
    {:ok, jwt} = LogApiWeb.JWT.generate_jwt(application)

    conn
    |> put_req_header("authorization", "Application " <> jwt)
  end

  defp get_owner(application) do
    Wait.until(fn -> Repo.get_by(Owner, application_uuid: application.uuid) end)
  end
end
