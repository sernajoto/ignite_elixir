defmodule RockliveryWeb.UsersControllerTest do
  use RockliveryWeb.ConnCase, async: true

  import Rocklivery.Factory

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
      insert(:user)
      id = "249a7ca0-0442-4eab-a574-445d8e1005dc"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end
  end
end
