defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "age" => 24,
      "address" => "Rua dos Testes, 42",
      "cep" => "18078344",
      "cpf" => "12345678901",
      "email" => "gui@teste.com",
      "password" => "123456",
      "name" => "Guilherme"
    }
  end

  def user_factory do
    %User{
      age: 24,
      address: "Rua dos Testes, 42",
      cep: "18078344",
      cpf: "12345678901",
      email: "gui@teste.com",
      password: "123456",
      name: "Guilherme",
      id: "249a7ca0-0442-4eab-a574-445d8e1005dc"
    }
  end

  def cep_info_factory do
    %{
      "cep" => "18078-344",
      "logradouro" => "Rua Antônio Silva Saladino",
      "complemento" => "",
      "bairro" => "Parque Vitória Régia",
      "localidade" => "Sorocaba",
      "uf" => "SP",
      "ibge" => "3552205",
      "gia" => "6695",
      "ddd" => "15",
      "siafi" => "7145"
    }
  end
end
