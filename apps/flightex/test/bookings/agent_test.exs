defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  setup do
    BookingAgent.start_link(%{})

    uuid = "15b66aaf-318d-47cf-bc92-40b5b51990da"

    {:ok, uuid: uuid}
  end

  describe "save/1" do
    test "saves a booking" do
      booking = build(:booking)

      assert BookingAgent.save(booking) == :ok
    end
  end

  describe "get/1" do
    test "when the booking is found, returns the booking", %{uuid: uuid} do
      booking = build(:booking, id: uuid)

      BookingAgent.save(booking)

      response = BookingAgent.get(uuid)

      expected_response = {:ok, booking}

      assert response == expected_response
    end

    test "when the booking is not found, returns an error" do
      response = BookingAgent.get("00000000000")

      expected_response = {:error, "Booking not found"}

      assert response == expected_response
    end
  end

  describe "list_from_date_range/1" do
    test "when find bookings in the date range, returns a booking list" do
      booking1 =
        build(:booking,
          complete_date: ~N[2021-04-21 00:00:00],
          id: "26b66aaf-318d-47cf-bc92-40b5b51990db"
        )

      booking2 =
        build(:booking,
          complete_date: ~N[2021-04-22 00:00:00],
          id: "36b66aaf-318d-47cf-bc92-40b5b51990db"
        )

      booking3 =
        build(:booking,
          complete_date: ~N[2021-04-23 00:00:00],
          id: "46b66aaf-318d-47cf-bc92-40b5b51990db"
        )

      BookingAgent.save(booking1)
      BookingAgent.save(booking2)
      BookingAgent.save(booking3)

      response =
        BookingAgent.list_from_date_range(~N[2021-04-22 00:00:00], ~N[2021-04-24 00:00:00])

      expected_response = [
        %Booking{
          complete_date: ~N[2021-04-22 00:00:00],
          destination_city: "Paris",
          id: "36b66aaf-318d-47cf-bc92-40b5b51990db",
          origin_city: "São Paulo",
          user_id: "f8b92836-c783-423d-aaf0-0e9ef55d4cc9"
        },
        %Booking{
          complete_date: ~N[2021-04-23 00:00:00],
          destination_city: "Paris",
          id: "46b66aaf-318d-47cf-bc92-40b5b51990db",
          origin_city: "São Paulo",
          user_id: "f8b92836-c783-423d-aaf0-0e9ef55d4cc9"
        }
      ]

      assert response == expected_response
    end
  end
end
