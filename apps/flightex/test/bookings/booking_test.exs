defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case

  alias Flightex.Bookings.Booking

  describe "build/4" do
    test "when all params are valid, returns a booking" do
      response =
        Booking.build("2021-04-22", "São Paulo", "Paris", "f8b92836-c783-423d-aaf0-0e9ef55d4cc9")

      assert {:ok,
              %Booking{
                id: _id,
                complete_date: ~N[2021-04-22 00:00:00],
                origin_city: "São Paulo",
                destination_city: "Paris",
                user_id: "f8b92836-c783-423d-aaf0-0e9ef55d4cc9"
              }} = response
    end

    test "when the complete date is invalid, returns an error" do
      response =
        Booking.build("22/04/2021", "São Paulo", "Paris", "f8b92836-c783-423d-aaf0-0e9ef55d4cc9")

      expected_response = {:error, "Invalid date, use the format yyyy-mm-dd"}

      assert response == expected_response
    end
  end
end
