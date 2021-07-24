defmodule Exmeal.Users.GetTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.{Error, User}
  alias Exmeal.Users.Get

  describe "by_id/1" do
    test "when a valid id is given, returns the user" do
      user = insert(:user)

      response = Get.by_id(user.id)

      assert {:ok, %User{id: _id, name: "Guilherme", cpf: "11111111111", email: "gui@test.com"}} =
               response
    end

    test "when an invalid id is given, returns an error" do
      response = Get.by_id("249a7ca0-0442-4eab-a574-445d8e1005dc")

      expected_response = {:error, %Error{result: "User not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
