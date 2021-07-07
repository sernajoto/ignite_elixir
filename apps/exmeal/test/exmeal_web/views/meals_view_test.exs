defmodule ExmealWeb.MealsViewTest do
  use ExmealWeb.ConnCase, async: true

  import Phoenix.View
  import Exmeal.Factory

  alias Exmeal.Meal
  alias ExmealWeb.MealsView

  test "render create.json" do
    meal = build(:meal)

    response = render(MealsView, "create.json", meal: meal)

    assert %{
             message: "Meal created!",
             meal: %Meal{
               description: "Banana",
               date: "2021-01-01 23:00:07",
               calories: 50,
               id: "0a7bed00-df7a-4def-99dd-091324c1b8e5"
             }
           } = response
  end

  test "render meal.json" do
    meal = build(:meal)

    response = render(MealsView, "meal.json", meal: meal)

    assert %{
             meal: %Meal{
               description: "Banana",
               date: "2021-01-01 23:00:07",
               calories: 50,
               id: "0a7bed00-df7a-4def-99dd-091324c1b8e5"
             }
           } = response
  end
end
