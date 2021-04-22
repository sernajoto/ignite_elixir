defmodule Flightex.Factory do
  use ExMachina

  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  def user_factory do
    %User{
      id: "f8b92836-c783-423d-aaf0-0e9ef55d4cc9",
      name: "Gui",
      email: "gui@test.com",
      cpf: "12345678900"
    }
  end

  def booking_factory do
    %Booking{
      id: "16b66aaf-318d-47cf-bc92-40b5b51990db",
      complete_date: ~N[2021-04-22 00:00:00],
      origin_city: "São Paulo",
      destination_city: "Paris",
      user_id: "f8b92836-c783-423d-aaf0-0e9ef55d4cc9"
    }
  end
end
