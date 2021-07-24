defmodule Exmeal.Users.DeleteTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.{Error, User}
  alias Exmeal.Users.Delete

  describe "call/1" do
    test "when a valid id is given, returns the user" do
      user = insert(:user)

      response = Delete.call(user.id)

      assert {:ok, %User{id: _id, name: "Guilherme", cpf: "11111111111", email: "gui@test.com"}} =
               response
    end

    test "when an invalid id is given, returns an error" do
      response = Delete.call("249a7ca0-0442-4eab-a574-445d8e1005dc")

      expected_response = {:error, %Error{result: "User not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
