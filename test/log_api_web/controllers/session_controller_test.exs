defmodule LogApiWeb.SessionControllerTest do
  use LogApiWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "authenticate application" do
    setup [
      :register_application,
    ]

    @tag :web
    test "creates session and renders session when data is valid", %{conn: conn} do
      conn = post conn, session_path(conn, :create), application: %{
        display_name: "crossover",
        password: "sekret"
      }
      json = json_response(conn, 201)["application"]
      token = json["token"]
      application_id = json["application_id"]

      assert json == %{
        "display_name" => "crossover",
        "token"        => token,
        "application_id" => application_id
      }
      refute token == ""
    end

    @tag :web
    test "does not create session and renders errors when password does not match", %{conn: conn} do
      conn = post conn, session_path(conn, :create), application: %{
        display_name: "crossover",
        password: "invalidpassword"
      }

      assert json_response(conn, 422)["errors"] == %{
        "display_name or password" => [
          "is invalid"
        ]
      }
    end

    @tag :web
    test "does not create session and renders errors when application not found", %{conn: conn} do
      conn = post conn, session_path(conn, :create), application: %{
        display_name: "doesnotexist",
        password: "some"
      }

      assert json_response(conn, 422)["errors"] == %{
        "display_name or password" => [
          "is invalid"
        ]
      }
    end
  end
end
