defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def create(from_date, to_date, filename \\ "report.csv") do
    from_date_naive = naive_date_time_from_string(from_date)
    to_date_naive = naive_date_time_from_string(to_date)

    booking_list = build_booking_list(from_date_naive, to_date_naive)

    File.write(filename, booking_list)
  end

  defp build_booking_list(from_date, to_date) do
    BookingAgent.list_from_date_range(from_date, to_date)
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp booking_string(%Booking{
         complete_date: complete_date,
         destination_city: destination_city,
         origin_city: origin_city,
         user_id: user_id
       }) do
    "#{user_id},#{origin_city},#{destination_city},#{NaiveDateTime.to_string(complete_date)}\n"
  end

  defp naive_date_time_from_string(string_date) do
    {:ok, date} = Date.from_iso8601(string_date)
    {:ok, naive_date} = NaiveDateTime.new(date, ~T[00:00:00])
    naive_date
  end
end
