defmodule ExmealWeb.UsersControllerTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  describe "create/2" do
    test "when all params are valid, creates an user", %{conn: conn} do
      params = %{
        "name" => "Guilherme",
        "cpf" => "11111111111",
        "email" => "gui@mail.com"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "name" => "Guilherme",
                 "cpf" => "11111111111",
                 "email" => "gui@mail.com",
                 "id" => _id
               }
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        "name" => "Guilherme",
        "cpf" => "123",
        "email" => "mail"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "cpf" => ["should be 11 character(s)"],
          "email" => ["has invalid format"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when id exist, delete the user", %{conn: conn} do
      user = insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, user.id))
        |> response(:no_content)

      assert response == ""
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = "249a7ca0-0442-4eab-a574-445d8e1005dc"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found"}

      assert response == expected_response
    end
  end

  describe "show/2" do
    test "when id exist, return the user", %{conn: conn} do
      user = insert(:user)

      response =
        conn
        |> get(Routes.users_path(conn, :show, user.id))
        |> json_response(:ok)

      expected_response = %{
        "user" => %{
          "name" => "Guilherme",
          "cpf" => "11111111111",
          "email" => "gui@test.com",
          "id" => "1a7bed00-df7a-4def-99dd-091324c1b8e5"
        }
      }

      assert response == expected_response
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = "249a7ca0-0442-4eab-a574-445d8e1005dc"

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found"}

      assert response == expected_response
    end
  end

  describe "update/2" do
    test "when id exist, update the user", %{conn: conn} do
      user = insert(:user)

      params = %{
        "name" => "Sernajoto",
        "email" => "serna@test.com"
      }

      response =
        conn
        |> put(Routes.users_path(conn, :update, user.id, params))
        |> json_response(:ok)

      expected_response = %{
        "user" => %{
          "name" => "Sernajoto",
          "cpf" => "11111111111",
          "email" => "serna@test.com",
          "id" => "1a7bed00-df7a-4def-99dd-091324c1b8e5"
        }
      }

      assert response == expected_response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      user = insert(:user)

      params = %{
        "cpf" => "123",
        "email" => "mail"
      }

      response =
        conn
        |> put(Routes.users_path(conn, :update, user.id, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "cpf" => ["should be 11 character(s)"],
          "email" => ["has invalid format"]
        }
      }

      assert response == expected_response
    end

    test "when not exist id, return an error", %{conn: conn} do
      id = "249a7ca0-0442-4eab-a574-445d8e1005dc"

      response =
        conn
        |> put(Routes.users_path(conn, :update, id))
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found"}

      assert response == expected_response
    end
  end
end
