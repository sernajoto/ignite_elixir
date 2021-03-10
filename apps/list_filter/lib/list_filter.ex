defmodule ListFilter do
  require Integer

  def call(list) do
    Enum.filter(list, fn elem -> integer?(elem) end)
    |> Enum.map(fn elem -> String.to_integer(elem) end)
    |> Enum.filter(fn elem -> Integer.is_odd(elem) end)
    |> length()
  end

  defp integer?(elem) do
    case Integer.parse(elem) do
      {_int, ""} -> true
      _ -> false
    end
  end
end
