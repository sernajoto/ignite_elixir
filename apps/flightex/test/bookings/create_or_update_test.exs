defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.CreateOrUpdate
  alias Flightex.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      Flightex.start_agents()

      user = build(:user)
      UserAgent.save(user)

      :ok
    end

    test "when all params are valid, saves the booking" do
      params = %{
        complete_date: "2021-04-22",
        origin_city: "São Paulo",
        destination_city: "Paris",
        user_id: "f8b92836-c783-423d-aaf0-0e9ef55d4cc9"
      }

      response = CreateOrUpdate.call(params)

      assert {:ok, _id} = response
    end

    test "when user is not exists, returns an error" do
      params = %{
        complete_date: "2021-04-22",
        origin_city: "São Paulo",
        destination_city: "Paris",
        user_id: "f8b92836-c783-423d-aaf0-0e9ef55d4cc7"
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end

    test "when the complete date is invalid, returns an error" do
      params = %{
        complete_date: "22-04-2021",
        origin_city: "São Paulo",
        destination_city: "Paris",
        user_id: "f8b92836-c783-423d-aaf0-0e9ef55d4cc9"
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid date, use the format yyyy-mm-dd"}

      assert response == expected_response
    end
  end
end
