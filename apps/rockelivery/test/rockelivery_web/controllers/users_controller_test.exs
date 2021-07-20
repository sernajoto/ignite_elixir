defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = %{
        "age" => 24,
        "address" => "Rua dos Testes, 42",
        "cep" => "12345678",
        "cpf" => "12345678901",
        "email" => "gui@teste.com",
        "password" => "123456",
        "name" => "Guilherme"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "address" => "Rua dos Testes, 42",
                 "age" => 24,
                 "cpf" => "12345678901",
                 "email" => "gui@teste.com",
                 "id" => _id
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = %{
        "password" => "123456",
        "name" => "Guilherme"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "address" => ["can't be blank"],
          "age" => ["can't be blank"],
          "cep" => ["can't be blank"],
          "cpf" => ["can't be blank"],
          "email" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when there is a user with the given id, deletes the user", %{conn: conn} do
      user = insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, user.id))
        |> response(:no_content)

      assert response == ""
    end

    test "when there is no user with the given id, returns the error", %{conn: conn} do
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
    test "when there is a user with the given id, show the user", %{conn: conn} do
      user = insert(:user)

      response =
        conn
        |> get(Routes.users_path(conn, :show, user.id))
        |> json_response(:ok)

      expected_response = %{
        "user" => %{
          "address" => "Rua dos Testes, 42",
          "age" => 24,
          "cpf" => "12345678901",
          "email" => "gui@teste.com",
          "id" => "249a7ca0-0442-4eab-a574-445d8e1005dc"
        }
      }

      assert response == expected_response
    end

    test "when there is no user with the given id, returns the error", %{conn: conn} do
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
    test "when there is a user with the given id, update the user", %{conn: conn} do
      user = insert(:user)

      params = %{
        "age" => 25,
        "email" => "serna@teste.com"
      }

      response =
        conn
        |> put(Routes.users_path(conn, :update, user.id, params))
        |> json_response(:ok)

      expected_response = %{
        "user" => %{
          "address" => "Rua dos Testes, 42",
          "age" => 25,
          "cpf" => "12345678901",
          "email" => "serna@teste.com",
          "id" => "249a7ca0-0442-4eab-a574-445d8e1005dc"
        }
      }

      assert response == expected_response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      user = insert(:user)

      params = %{
        "password" => "123",
        "age" => 15
      }

      response =
        conn
        |> put(Routes.users_path(conn, :update, user.id, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "age" => ["must be greater than or equal to 18"],
          "password" => ["should be at least 6 character(s)"]
        }
      }

      assert response == expected_response
    end

    test "when there is no user with the given id, returns the error", %{conn: conn} do
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
