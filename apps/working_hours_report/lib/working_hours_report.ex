defmodule WorkingHoursReport do
  alias WorkingHoursReport.Parser

  def build(filename) do
    parsed_file = Parser.parse_file(filename)
    report_acc = report_acc(parsed_file)
    Enum.reduce(parsed_file, report_acc, fn line, report -> sum_hours(line, report) end)
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
    month_list = index_to_list(parsed_file, 3)
    year_list = index_to_list(parsed_file, 4)

    all_hours = list_to_acc(name_list)

    all_months = list_to_acc(month_list)
    hours_per_month = list_to_acc(name_list, all_months)

    all_years = list_to_acc(year_list)
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
