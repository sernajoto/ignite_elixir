defmodule ListLength do
  def call(list), do: len(list, 0)

  defp len([], acc), do: acc

  defp len([_head | tail], acc), do: len(tail, acc + 1)
end
