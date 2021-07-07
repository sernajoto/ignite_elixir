defmodule Exmeal.Factory do
  use ExMachina.Ecto, repo: Exmeal.Repo

  alias Exmeal.Meal

  def meal_params_factory do
    %{
      description: "Banana",
      date: "2021-01-01 23:00:07",
      calories: 50
    }
  end

  def meal_factory do
    %Meal{
      description: "Banana",
      date: "2021-01-01 23:00:07",
      calories: 50,
      id: "0a7bed00-df7a-4def-99dd-091324c1b8e5"
    }
  end
end
