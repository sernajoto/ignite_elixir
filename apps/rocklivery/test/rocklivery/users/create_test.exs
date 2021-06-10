defmodule Rocklivery.Users.CreateTest do
  use Rocklivery.DataCase, async: true

  import Rocklivery.Factory

  alias Rocklivery.{Error, User}
  alias Rocklivery.Users.Create

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      response = Create.call(params)

      assert {:ok, %User{id: _id, age: 24, email: "gui@teste.com"}} = response
    end

    test "when the are invalid params, returns an error" do
      params = build(:user_params, %{password: "123", age: 15})

      response = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response

      assert errors_on(changeset) == expected_response
    end
  end
end
