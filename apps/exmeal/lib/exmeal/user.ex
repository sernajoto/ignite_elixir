defmodule Exmeal.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Exmeal.Meal

  @derive {Jason.Encoder, only: [:id, :name, :cpf, :email]}

  @required_params [:name, :cpf, :email]

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :name, :string
    field :cpf, :string
    field :email, :string

    has_many :meals, Meal

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:name, min: 5)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:cpf, is: 11)
    |> unique_constraint(:email)
    |> unique_constraint(:cpf)
  end
end
