defmodule Exmeal.Users.UpdateTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.{Error, User}
  alias Exmeal.Users.Update

  describe "call/1" do
    test "when a valid id is given, returns the user" do
      user = insert(:user)

      params = %{"id" => user.id, "name" => "Sernajoto", "email" => "serna@test.com"}

      response = Update.call(params)

      assert {:ok, %User{id: _id, name: "Sernajoto", cpf: "11111111111", email: "serna@test.com"}} =
               response
    end

    test "when there are invalid params, returns an error" do
      user = insert(:user)

      params = %{"id" => user.id, "name" => "Sernajoto", "email" => "mail"}

      response = Update.call(params)

      expected_response = %{
        email: ["has invalid format"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response

      assert errors_on(changeset) == expected_response
    end

    test "when an invalid id is given, returns an error" do
      response = Update.call(%{"id" => "249a7ca0-0442-4eab-a574-445d8e1005dc"})

      expected_response = {:error, %Error{result: "User not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
