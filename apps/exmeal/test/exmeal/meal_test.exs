defmodule Exmeal.MealTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Ecto.Changeset
  alias Exmeal.Meal

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:meal_params)

      response = Meal.changeset(params)

      assert %Changeset{changes: %{description: "Banana"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:meal_params, %{calories: -1})

      response = Meal.changeset(params)

      expected_response = %{
        calories: ["must be greater than or equal to 0"]
      }

      assert errors_on(response) == expected_response
    end
  end

  describe "changeset/2" do
    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:meal_params)

      update_params = %{description: "Uva"}

      response =
        params
        |> Meal.changeset()
        |> Meal.changeset(update_params)

      assert %Changeset{changes: %{description: "Uva"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:meal_params)

      update_params = %{calories: -1}

      response =
        params
        |> Meal.changeset()
        |> Meal.changeset(update_params)

      expected_response = %{
        calories: ["must be greater than or equal to 0"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
