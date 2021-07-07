defmodule Exmeal.Meals.DeleteTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.{Error, Meal}
  alias Exmeal.Meals.Delete

  describe "call/1" do
    test "when a valid id is given, returns the meal" do
      meal = insert(:meal)

      response = Delete.call(meal.id)

      assert {:ok, %Meal{id: _id, calories: 50, description: "Banana"}} = response
    end

    test "when an invalid id is given, returns an error" do
      response = Delete.call("249a7ca0-0442-4eab-a574-445d8e1005dc")

      expected_response = {:error, %Error{result: "Meal not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
