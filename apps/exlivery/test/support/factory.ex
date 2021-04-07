defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
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

  def item_factory do
    %Item{
      category: :pizza,
      description: "Pizza de calabresa",
      quantity: 1,
      unity_price: Decimal.new("40.50")
    }
  end

  def order_factory do
    %Order{
      delivery_address: "Rua dos Testes",
      items: [
        build(:item),
        build(:item,
          category: :japonesa,
          description: "Temaki de salmão",
          quantity: 2,
          unity_price: Decimal.new("20.90")
        )
      ],
      total_price: Decimal.new("82.30"),
      user_cpf: "12345678900"
    }
  end
end
