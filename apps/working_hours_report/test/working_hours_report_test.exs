defmodule WorkingHoursReportTest do
  use ExUnit.Case

  describe "build/1" do
    test "builds the report" do
      filename = "gen_report_test.csv"

      response = WorkingHoursReport.build(filename)

      expected_response = %{
        "all_hours" => %{"Daniele" => 17, "Giuliano" => 3, "Mayk" => 5},
        "hours_per_month" => %{
          "Daniele" => %{"abril" => 7, "dezembro" => 10, "fevereiro" => 0, "janeiro" => 0},
          "Giuliano" => %{"abril" => 0, "dezembro" => 0, "fevereiro" => 3, "janeiro" => 0},
          "Mayk" => %{"abril" => 0, "dezembro" => 0, "fevereiro" => 4, "janeiro" => 1}
        },
        "hours_per_year" => %{
          "Daniele" => %{"2016" => 10, "2018" => 7, "2019" => 0, "2020" => 0},
          "Giuliano" => %{"2016" => 0, "2018" => 0, "2019" => 3, "2020" => 0},
          "Mayk" => %{"2016" => 0, "2018" => 0, "2019" => 4, "2020" => 1}
        }
      }

      assert response == expected_response
    end
  end
end
