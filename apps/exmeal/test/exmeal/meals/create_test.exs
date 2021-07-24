defmodule Exmeal.Meals.CreateTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.{Error, Meal}
  alias Exmeal.Meals.Create

  describe "call/1" do
    setup do
      insert(:user)

      :ok
    end

    test "when all params are valid, returns the meal" do
      params = build(:meal_params)

      response = Create.call(params)

      assert {:ok, %Meal{id: _id, calories: 50, description: "Banana"}} = response
    end

    test "when there are invalid params, returns an error" do
      params = build(:meal_params, %{calories: -1})

      response = Create.call(params)

      expected_response = %{
        calories: ["must be greater than or equal to 0"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response

      assert errors_on(changeset) == expected_response
    end
  end
end
