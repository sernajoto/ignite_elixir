defmodule WorkingHoursReport.ParserTest do
  use ExUnit.Case

  alias WorkingHoursReport.Parser

  describe "parse_file/1" do
    test "parses the file" do
      filename = "gen_report_test.csv"

      response =
        filename
        |> Parser.parse_file()
        |> Enum.map(& &1)

      expected_response = [
        ["Daniele", 7, "29", "abril", "2018"],
        ["Daniele", 5, "27", "dezembro", "2016"],
        ["Daniele", 5, "21", "dezembro", "2016"],
        ["Mayk", 4, "9", "fevereiro", "2019"],
        ["Mayk", 1, "2", "janeiro", "2020"],
        ["Giuliano", 3, "13", "fevereiro", "2019"]
      ]

      assert response == expected_response
    end
  end
end
