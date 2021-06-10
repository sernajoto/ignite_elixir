defmodule RockliveryWeb.UsersViewTest do
  use RockliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rocklivery.Factory

  alias RockliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created!",
             user: %Rocklivery.User{
               address: "Rua dos Testes, 42",
               age: 24,
               cep: "12345678",
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
