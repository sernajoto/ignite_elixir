defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Users.User

  def user_factory do
    %User{
      address: "Rua dos Testes",
      age: 24,
      cpf: "12345678900",
      email: "guilherme@teste.com",
      name: "Guilherme"
    }
  end
end
