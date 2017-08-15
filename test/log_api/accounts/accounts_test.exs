defmodule LogApi.AccountsTest do
  use LogApi.DataCase

  alias LogApi.Accounts
  alias LogApi.Accounts.Application
  alias LogApi.Auth

  describe "register application" do
    @tag :integration
    test "should succeed with valid data" do
      assert {:ok, %Application{} = application} = Accounts.register_application(build(:application))

      assert application.display_name == "crossover"
    end

    @tag :integration
    test "should fail with invalid data and return error" do
      assert {:error, :validation_failure, errors} = Accounts.register_application(build(:application, display_name: ""))

      assert errors == %{display_name: ["can't be empty"]}
    end

    @tag :integration
    test "should fail when display_name already taken and return error" do
      assert {:ok, %Application{}} = Accounts.register_application(build(:application))
      assert {:error, :validation_failure, errors} = Accounts.register_application(build(:application, display_name: "crossover"))

      assert errors == %{display_name: ["has already been taken"]}
    end

    @tag :integration
    test "should fail when registering identical display_name at same time and return error" do
      1..2
      |> Enum.map(fn x -> Task.async(fn -> Accounts.register_application(build(:application, display_name: "crossover")) end)  end)
      |> Enum.map(&Task.await/1)
    end

    @tag :integration
    test "should convert display_name to lowercase" do
      assert {:ok, %Application{} = application} = Accounts.register_application(build(:application, display_name: "CROSSOVER"))

      assert application.display_name == "crossover"
    end

    @tag :integration
    test "should hash password" do
      assert {:ok, %Application{} = application} = Accounts.register_application(build(:application))

      assert Auth.validate_password("sekret", application.application_secret)
    end
  end
end
