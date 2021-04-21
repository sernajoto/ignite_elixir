defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent

  def call(%{
        complete_date: complete_date,
        origin_city: origin_city,
        destination_city: destination_city,
        user_id: user_id
      }) do
    with {:ok, _user} <- UserAgent.get(user_id),
         {:ok, booking} <- Booking.build(complete_date, origin_city, destination_city, user_id) do
      save_booking(booking)
    else
      error -> error
    end
  end

  defp save_booking(%Booking{id: id} = booking) do
    BookingAgent.save(booking)

    {:ok, id}
  end
end
