defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "creates the report file" do
      OrderAgent.start_link(%{})

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      expected_response =
        "12345678900,pizza,1,40.50japonesa,2,20.90,82.30\n" <>
          "12345678900,pizza,1,40.50japonesa,2,20.90,82.30\n"

      Report.create("exlivery_report_test.csv")

      response = File.read!("exlivery_report_test.csv")

      assert response == expected_response
    end
  end
end
