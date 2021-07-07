defmodule ExmealWeb.MealsControllerTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  describe "create/2" do
    test "when all params are valid, creates a meal", %{conn: conn} do
      params = %{
        "description" => "Banana",
        "date" => "2021-01-01 23:00:07",
        "calories" => 50
      }

      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "Meal created!",
               "meal" => %{
                 "description" => "Banana",
                 "date" => "2021-01-01T23:00:07",
                 "calories" => 50,
                 "id" => _id
               }
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        "description" => "Banana",
        "date" => "2021-01-01 23:00:07",
        "calories" => -1
      }

      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "calories" => ["must be greater than or equal to 0"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when id exist, delete the meal", %{conn: conn} do
      meal = insert(:meal)

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, meal.id))
        |> response(:no_content)

      assert response == ""
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = "249a7ca0-0442-4eab-a574-445d8e1005dc"

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, id))
        |> json_response(:not_found)

      expected_response = %{"message" => "Meal not found"}

      assert response == expected_response
    end
  end

  describe "show/2" do
    test "when id exist, return the meal", %{conn: conn} do
      meal = insert(:meal)

      response =
        conn
        |> get(Routes.meals_path(conn, :show, meal.id))
        |> json_response(:ok)

      expected_response = %{
        "meal" => %{
          "description" => "Banana",
          "date" => "2021-01-01T23:00:07",
          "calories" => 50,
          "id" => "0a7bed00-df7a-4def-99dd-091324c1b8e5"
        }
      }

      assert response == expected_response
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = "249a7ca0-0442-4eab-a574-445d8e1005dc"

      response =
        conn
        |> get(Routes.meals_path(conn, :show, id))
        |> json_response(:not_found)

      expected_response = %{"message" => "Meal not found"}

      assert response == expected_response
    end
  end

  describe "update/2" do
    test "when id exist, update the meal", %{conn: conn} do
      meal = insert(:meal)

      params = %{
        "description" => "Uva",
        "date" => "2021-01-01 20:00:07",
        "calories" => 13
      }

      response =
        conn
        |> put(Routes.meals_path(conn, :update, meal.id, params))
        |> json_response(:ok)

      expected_response = %{
        "meal" => %{
          "description" => "Uva",
          "date" => "2021-01-01T20:00:07",
          "calories" => 13,
          "id" => "0a7bed00-df7a-4def-99dd-091324c1b8e5"
        }
      }

      assert response == expected_response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      meal = insert(:meal)

      params = %{
        "description" => "Uva",
        "date" => "2021-01-01 20:00:07",
        "calories" => -1
      }

      response =
        conn
        |> put(Routes.meals_path(conn, :update, meal.id, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "calories" => ["must be greater than or equal to 0"]
        }
      }

      assert response == expected_response
    end

    test "when not exist id, return an error", %{conn: conn} do
      id = "249a7ca0-0442-4eab-a574-445d8e1005dc"

      response =
        conn
        |> put(Routes.meals_path(conn, :update, id))
        |> json_response(:not_found)

      expected_response = %{"message" => "Meal not found"}

      assert response == expected_response
    end
  end
end
