defmodule Exmeal.Factory do
  use ExMachina.Ecto, repo: Exmeal.Repo

  alias Exmeal.{Meal, User}

  def meal_params_factory do
    %{
      description: "Banana",
      date: "2021-01-01 23:00:07",
      calories: 50,
      user_id: "1a7bed00-df7a-4def-99dd-091324c1b8e5"
    }
  end

  def meal_factory do
    insert(:user)

    %Meal{
      description: "Banana",
      date: "2021-01-01 23:00:07",
      calories: 50,
      id: "0a7bed00-df7a-4def-99dd-091324c1b8e5",
      user_id: "1a7bed00-df7a-4def-99dd-091324c1b8e5"
    }
  end

  def user_params_factory do
    %{
      name: "Guilherme",
      cpf: "11111111111",
      email: "gui@test.com"
    }
  end

  def user_factory do
    %User{
      name: "Guilherme",
      cpf: "11111111111",
      email: "gui@test.com",
      id: "1a7bed00-df7a-4def-99dd-091324c1b8e5"
    }
  end
end
