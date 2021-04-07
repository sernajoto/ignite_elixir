defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent

  setup do
    UserAgent.start_link(%{})

    cpf = "12345678900"

    {:ok, cpf: cpf}
  end

  describe "save/1" do
    test "saves the user" do
      user = build(:user)

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    test "when the user is found, returns the user", %{cpf: cpf} do
      user = build(:user, cpf: cpf)

      UserAgent.save(user)

      response = UserAgent.get(cpf)

      expected_response = {:ok, user}

      assert response == expected_response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("00000000000")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
