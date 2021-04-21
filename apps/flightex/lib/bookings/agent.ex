defmodule Flightex.Bookings.Agent do
  use Agent

  alias Flightex.Bookings.Booking

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{} = booking), do: Agent.update(__MODULE__, &update_state(&1, booking))

  def get(uuid), do: Agent.get(__MODULE__, &get_booking(&1, uuid))

  def list_from_date_range(from_date, to_date) do
    Agent.get(__MODULE__, &get_bookings_from_date_range(&1, from_date, to_date))
  end

  defp update_state(state, %Booking{id: id} = booking), do: Map.put(state, id, booking)

  defp get_booking(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end

  defp get_bookings_from_date_range(state, from_date, to_date) do
    Enum.filter(state, fn {_uuid, booking} ->
      compare_between_date_range(booking.complete_date, from_date, to_date)
    end)
    |> Enum.map(fn {_uuid, booking} -> booking end)
  end

  defp compare_between_date_range(date, from_date, to_date) do
    if NaiveDateTime.compare(date, from_date) in [:gt, :eq] and
         NaiveDateTime.compare(date, to_date) in [:lt, :eq] do
      true
    else
      false
    end
  end
end
