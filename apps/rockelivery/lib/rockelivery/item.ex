defmodule Rockelivery.Item do
  use Ecto.Schema

  import Ecto.Changeset

  alias Rockelivery.Order

  @required_params [:category, :description, :price, :photo]
  @items_categories [:food, :drink, :desert]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "items" do
    field :category, Ecto.Enum, values: @items_categories
    field :description, :string
    field :price, :decimal
    field :photo, :string

    many_to_many :orders, Order, join_through: "orders_items"

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:description, min: 1)
    |> validate_number(:price, greater_than: 0)
  end
end
