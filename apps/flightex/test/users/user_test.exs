defmodule Flightex.Users.UserTest do
  use ExUnit.Case

  alias Flightex.Users.User

  describe "build/3" do
    test "when all params are valid, returns an user" do
      response = User.build("Gui", "gui@test.com", "12345678900")

      assert {:ok, %User{name: "Gui", email: "gui@test.com", cpf: "12345678900", id: _id}} =
               response
    end

    test "when there are invalid params, returns an error" do
      response = User.build("Gui", "gui@test.com", 12_345_678_900)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
