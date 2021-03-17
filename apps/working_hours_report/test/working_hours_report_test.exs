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

  describe "build_from_many/1" do
    test "when a file list is provided, builds the report" do
      filenames = ["gen_report_test.csv", "gen_report_test_2.csv"]

      response = WorkingHoursReport.build_from_many(filenames)

      expected_response =
        {:ok,
         %{
           "all_hours" => %{"Daniele" => 36, "Giuliano" => 6, "Mayk" => 10},
           "hours_per_month" => %{
             "Daniele" => %{
               "abril" => 14,
               "dezembro" => 20,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 2
             },
             "Giuliano" => %{
               "abril" => 0,
               "dezembro" => 0,
               "fevereiro" => 6,
               "janeiro" => 0,
               "julho" => 0
             },
             "Mayk" => %{
               "abril" => 0,
               "dezembro" => 0,
               "fevereiro" => 8,
               "janeiro" => 2,
               "julho" => 0
             }
           },
           "hours_per_year" => %{
             "Daniele" => %{"2016" => 20, "2017" => 2, "2018" => 14, "2019" => 0, "2020" => 0},
             "Giuliano" => %{"2016" => 0, "2017" => 0, "2018" => 0, "2019" => 6, "2020" => 0},
             "Mayk" => %{"2016" => 0, "2017" => 0, "2018" => 0, "2019" => 8, "2020" => 2}
           }
         }}

      assert response == expected_response
    end

    test "when a file list is not provided, returns an error" do
      response = WorkingHoursReport.build_from_many("banana")

      expected_response = {:error, "Please provide a list of strings"}

      assert response == expected_response
    end
  end
end
