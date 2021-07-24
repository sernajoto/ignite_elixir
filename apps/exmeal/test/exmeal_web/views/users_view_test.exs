defmodule ExmealWeb.UsersViewTest do
  use ExmealWeb.ConnCase, async: true

  import Phoenix.View
  import Exmeal.Factory

  alias Exmeal.User
  alias ExmealWeb.UsersView

  test "render create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created!",
             user: %User{
               name: "Guilherme",
               cpf: "11111111111",
               email: "gui@test.com",
               id: "1a7bed00-df7a-4def-99dd-091324c1b8e5"
             }
           } = response
  end

  test "render user.json" do
    user = build(:user)

    response = render(UsersView, "user.json", user: user)

    assert %{
             user: %User{
               name: "Guilherme",
               cpf: "11111111111",
               email: "gui@test.com",
               id: "1a7bed00-df7a-4def-99dd-091324c1b8e5"
             }
           } = response
  end
end
