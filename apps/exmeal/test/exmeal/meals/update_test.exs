defmodule Exmeal.Meals.UpdateTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.{Error, Meal}
  alias Exmeal.Meals.Update

  describe "call/1" do
    test "when a valid id is given, returns the meal" do
      meal = insert(:meal)

      params = %{"id" => meal.id, "description" => "Uva", "calories" => 12}

      response = Update.call(params)

      assert {:ok, %Meal{id: _id, description: "Uva", calories: 12}} = response
    end

    test "when there are invalid params, returns an error" do
      meal = insert(:meal)

      params = %{"id" => meal.id, "description" => "Uva", "calories" => -1}

      response = Update.call(params)

      expected_response = %{
        calories: ["must be greater than or equal to 0"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response

      assert errors_on(changeset) == expected_response
    end

    test "when an invalid id is given, returns an error" do
      response = Update.call(%{"id" => "249a7ca0-0442-4eab-a574-445d8e1005dc"})

      expected_response = {:error, %Error{result: "Meal not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
