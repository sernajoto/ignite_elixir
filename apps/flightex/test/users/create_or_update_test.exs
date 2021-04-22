defmodule Flightex.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, saves the user" do
      params = %{
        name: "Gui",
        email: "gui@test.com",
        cpf: "12345678900"
      }

      response = CreateOrUpdate.call(params)

      assert {:ok, _id} = response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Gui",
        email: "gui@test.com",
        cpf: 12_345_678_900
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
