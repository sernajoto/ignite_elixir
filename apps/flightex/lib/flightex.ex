defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.CreateOrUpdate, as: CreateOrUpdateBooking
  alias Flightex.Bookings.Report
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate, as: CreateOrUpdateUser

  def start_agents do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate create_or_update_user(params), to: CreateOrUpdateUser, as: :call
  defdelegate get_user(params), to: UserAgent, as: :get

  defdelegate create_or_update_booking(params), to: CreateOrUpdateBooking, as: :call
  defdelegate get_booking(params), to: BookingAgent, as: :get

  defdelegate generate_report(from_date, to_date), to: Report, as: :create
end
