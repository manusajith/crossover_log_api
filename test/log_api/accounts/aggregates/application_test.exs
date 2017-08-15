defmodule LogApi.Accounts.ApplicationTest do
  use LogApi.AggregateCase, aggregate: LogApi.Accounts.Aggregates.Application

  alias LogApi.Accounts.Events.ApplicationRegistered

  describe "register application" do
    @tag :unit
    test "should succeed when valid" do
      uuid = UUID.uuid4()

      assert_events build(:register_application, uuid: uuid), [
        %ApplicationRegistered{
          uuid:               uuid,
          display_name:       "crossover",
          application_secret: "",
        }
      ]
    end
  end
end
