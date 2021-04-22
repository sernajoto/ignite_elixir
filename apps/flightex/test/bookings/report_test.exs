defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Report

  describe "create/1" do
    test "creates the report file" do
      BookingAgent.start_link(%{})

      :booking
      |> build(complete_date: ~N[2021-04-21 00:00:00], id: "26b66aaf-318d-47cf-bc92-40b5b51990db")
      |> BookingAgent.save()

      :booking
      |> build(complete_date: ~N[2021-04-22 00:00:00], id: "36b66aaf-318d-47cf-bc92-40b5b51990db")
      |> BookingAgent.save()

      :booking
      |> build(complete_date: ~N[2021-04-23 00:00:00], id: "46b66aaf-318d-47cf-bc92-40b5b51990db")
      |> BookingAgent.save()

      expected_response =
        "f8b92836-c783-423d-aaf0-0e9ef55d4cc9,São Paulo,Paris,2021-04-22 00:00:00\n" <>
          "f8b92836-c783-423d-aaf0-0e9ef55d4cc9,São Paulo,Paris,2021-04-23 00:00:00\n"

      Report.create("2021-04-22", "2021-04-24", "flightex_report_test.csv")

      response = File.read!("flightex_report_test.csv")

      assert response == expected_response
    end
  end
end
