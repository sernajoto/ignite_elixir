defmodule Rocklivery.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :age, :cpf, :address, :email]}

  @required_params [:age, :address, :cep, :cpf, :email, :password, :name]

  @update_params @required_params -- [:password]

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :age, :integer
    field :address, :string
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string

    timestamps()
  end

  def changeset(params) do
    validate_changeset(%__MODULE__{}, params, @required_params)
  end

  def changeset(struct, params) do
    validate_changeset(struct, params, @update_params)
  end

  defp validate_changeset(struct, params, required_params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(required_params)
    |> validate_length(:password, min: 6)
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
    |> put_passsword_hash()
  end

  defp put_passsword_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_passsword_hash(changeset), do: changeset
end
