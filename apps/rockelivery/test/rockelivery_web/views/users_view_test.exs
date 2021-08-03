defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias Rockelivery.User
  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)
    token = "xpto1234"

    response = render(UsersView, "create.json", token: token, user: user)

    assert %{
             message: "User created!",
             token: "xpto1234",
             user: %User{
               address: "Rua dos Testes, 42",
               age: 24,
               cep: "18078344",
               cpf: "12345678901",
               email: "gui@teste.com",
               id: "249a7ca0-0442-4eab-a574-445d8e1005dc",
               inserted_at: nil,
               name: "Guilherme",
               password: "123456",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end

  test "renders user.json" do
    user = build(:user)

    response = render(UsersView, "user.json", user: user)

    assert %{
             user: %User{
               address: "Rua dos Testes, 42",
               age: 24,
               cep: "18078344",
               cpf: "12345678901",
               email: "gui@teste.com",
               id: "249a7ca0-0442-4eab-a574-445d8e1005dc",
               inserted_at: nil,
               name: "Guilherme",
               password: "123456",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end
end
