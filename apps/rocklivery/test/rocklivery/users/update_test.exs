defmodule Rocklivery.Users.UpdateTest do
  use Rocklivery.DataCase, async: true

  import Rocklivery.Factory

  alias Rocklivery.{Error, User}
  alias Rocklivery.Users.Update

  describe "call/1" do
    test "when all params are valid, returns the updated user" do
      user = insert(:user)

      params = %{"id" => user.id, "name" => "Sernajoto", "age" => 25}

      response = Update.call(params)

      assert {:ok, %User{id: _id, age: 25, name: "Sernajoto"}} = response
    end

    test "when there are invalid params, returns an error" do
      user = insert(:user)

      params = %{"id" => user.id, "password" => "123", "age" => 15}

      response = Update.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response

      assert errors_on(changeset) == expected_response
    end

    test "when there is no user with the given id, returns an error" do
      response = Update.call(%{"id" => "249a7ca0-0442-4eab-a574-445d8e1005dc"})

      expected_response = {:error, %Error{result: "User not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
