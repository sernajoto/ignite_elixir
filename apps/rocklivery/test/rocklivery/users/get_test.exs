defmodule Rocklivery.Users.GetTest do
  use Rocklivery.DataCase, async: true

  import Rocklivery.Factory

  alias Rocklivery.{Error, User}
  alias Rocklivery.Users.Get

  describe "by_id/1" do
    test "when there is a user with the given id, returns the user" do
      user = insert(:user)

      response = Get.by_id(user.id)

      assert {:ok, %User{id: _id, age: 24, email: "gui@teste.com"}} = response
    end

    test "when there is no user with the given id, returns an error" do
      response = Get.by_id("249a7ca0-0442-4eab-a574-445d8e1005dc")

      expected_response = {:error, %Error{result: "User not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
