defmodule LogApiWeb.LogControllerTest do
  use LogApiWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "record a log entry" do
    @tag :web
    test "should create and return log entry when data is valid", %{conn: conn} do
      conn = post authenticated_conn(conn), log_path(conn, :create), build(:log_entry)
      json = json_response(conn, 201)["log"]
      application_uuid = json["application_id"]

      assert json == %{
        "logger"    => "com.logger.service.Uploader",
        "level"     => "Error",
        "message"   => "The communication pipeline is broken",
        "application_id" => application_uuid
      }
    end
  end
end
