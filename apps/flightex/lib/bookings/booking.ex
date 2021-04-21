defmodule Flightex.Bookings.Booking do
  @keys [:id, :complete_date, :origin_city, :destination_city, :user_id]

  @enforce_keys @keys
  defstruct @keys

  def build(complete_date, origin_city, destination_city, user_id) do
    case Date.from_iso8601(complete_date) do
      {:ok, date} ->
        uuid = UUID.uuid4()
        {:ok, naive_date_time} = naive_date_time_from_string(date)

        {:ok,
         %__MODULE__{
           id: uuid,
           complete_date: naive_date_time,
           origin_city: origin_city,
           destination_city: destination_city,
           user_id: user_id
         }}

      _ ->
        {:error, "Invalid date, use the format yyyy-mm-dd"}
    end
  end

  defp naive_date_time_from_string(date) do
    date
    |> NaiveDateTime.new(~T[00:00:00])
  end
end
