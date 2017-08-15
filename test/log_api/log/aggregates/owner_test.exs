defmodule LogApi.Log.OwnerTest do
  use LogApi.DataCase

  import Commanded.Assertions.EventAssertions

  alias LogApi.Accounts
  alias LogApi.Accounts.Application
  alias LogApi.Log.Events.OwnerCreated

  describe "an owner" do
    @tag :integration
    test "should be created when application is registered" do
      assert {:ok, %Application{} = application} = Accounts.register_application(build(:application))

      assert_receive_event OwnerCreated, fn event ->
        assert event.application_uuid == application.uuid
        assert event.display_name     == application.display_name
      end
    end
  end
end
