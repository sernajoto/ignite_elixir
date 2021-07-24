defmodule Exmeal.Meal do
  use Ecto.Schema

  import Ecto.Changeset

  alias Exmeal.User

  @derive {Jason.Encoder, only: [:id, :description, :date, :calories]}

  @required_params [:description, :date, :calories, :user_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "meals" do
    field :description, :string
    field :date, :naive_datetime
    field :calories, :integer

    belongs_to :user, User

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_number(:calories, greater_than_or_equal_to: 0)
    |> foreign_key_constraint(:user_id)
  end
end
