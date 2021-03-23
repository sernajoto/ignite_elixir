defmodule WorkingHoursReport do
  alias WorkingHoursReport.Parser

  @months [
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  ]

  @years ["2016", "2017", "2018", "2019", "2020"]

  def build(filename) do
    parsed_file = Parser.parse_file(filename)
    report_acc = report_acc(parsed_file)
    Enum.reduce(parsed_file, report_acc, fn line, report -> sum_hours(line, report) end)
  end

  def build_from_many(filenames) when not is_list(filenames) do
    {:error, "Please provide a list of strings"}
  end

  def build_from_many(filenames) do
    result =
      filenames
      |> Task.async_stream(&build/1)
      |> Enum.reduce(
        build_report(%{}, %{}, %{}),
        fn {:ok, result}, report -> sum_reports(report, result) end
      )

    {:ok, result}
  end

  defp sum_reports(
         %{
           "all_hours" => all_hours1,
           "hours_per_month" => hours_per_month1,
           "hours_per_year" => hours_per_year1
         },
         %{
           "all_hours" => all_hours2,
           "hours_per_month" => hours_per_month2,
           "hours_per_year" => hours_per_year2
         }
       ) do
    all_hours = merge_maps(all_hours1, all_hours2)
    hours_per_month = merge_nested_maps(hours_per_month1, hours_per_month2)
    hours_per_year = merge_nested_maps(hours_per_year1, hours_per_year2)

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 -> value1 + value2 end)
  end

  defp merge_nested_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 -> merge_maps(value1, value2) end)
  end

  defp sum_hours([name, hours, _day, month, year], %{
         "all_hours" => all_hours,
         "hours_per_month" => hours_per_month,
         "hours_per_year" => hours_per_year
       }) do
    all_hours = Map.put(all_hours, name, all_hours[name] + hours)

    hours_per_month = nested_map_put(hours_per_month, name, month, hours)

    hours_per_year = nested_map_put(hours_per_year, name, year, hours)

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp report_acc(parsed_file) do
    name_list = index_to_list(parsed_file, 0)

    all_hours = list_to_acc(name_list)

    all_months = list_to_acc(@months)
    hours_per_month = list_to_acc(name_list, all_months)

    all_years = list_to_acc(@years)
    hours_per_year = list_to_acc(name_list, all_years)

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp index_to_list(parsed_file, index) do
    Enum.map(parsed_file, fn line -> Enum.at(line, index) end)
  end

  defp list_to_acc(list_to_acc, init \\ 0), do: Enum.into(list_to_acc, %{}, &{&1, init})

  defp nested_map_put(map, key, key_nested, value) do
    Map.put(map, key, Map.put(map[key], key_nested, map[key][key_nested] + value))
  end

  defp build_report(all_hours, hours_per_month, hours_per_year) do
    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end
end
