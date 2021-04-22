defmodule Flightex.Users.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Users.Agent, as: UserAgent

  setup do
    UserAgent.start_link(%{})

    uuid = "a8b92836-c783-423d-aaf0-0e9ef55d4cc8"

    {:ok, uuid: uuid}
  end

  describe "save/1" do
    test "saves an user" do
      user = build(:user)

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    test "when the user is found, returns the user", %{uuid: uuid} do
      user = build(:user, id: uuid)

      UserAgent.save(user)

      response = UserAgent.get(uuid)

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
