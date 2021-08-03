defmodule GetRepositories.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @derive {Jason.Encoder, only: [:id]}

  @required_params [:password]

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> put_passsword_hash()
  end

  defp put_passsword_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_passsword_hash(changeset), do: changeset
end
