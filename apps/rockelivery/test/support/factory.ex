defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      age: 24,
      address: "Rua dos Testes, 42",
      cep: "12345678",
      cpf: "12345678901",
      email: "gui@teste.com",
      password: "123456",
      name: "Guilherme"
    }
  end

  def user_factory do
    %User{
      age: 24,
      address: "Rua dos Testes, 42",
      cep: "12345678",
      cpf: "12345678901",
      email: "gui@teste.com",
      password: "123456",
      name: "Guilherme",
      id: "249a7ca0-0442-4eab-a574-445d8e1005dc"
    }
  end
end
