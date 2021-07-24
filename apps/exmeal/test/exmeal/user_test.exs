defmodule Exmeal.UserTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Ecto.Changeset
  alias Exmeal.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Guilherme"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:user_params, %{email: "mail"})

      response = User.changeset(params)

      expected_response = %{
        email: ["has invalid format"]
      }

      assert errors_on(response) == expected_response
    end
  end

  describe "changeset/2" do
    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:user_params)

      update_params = %{name: "Sernajoto"}

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{name: "Sernajoto"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:user_params)

      update_params = %{email: "mail"}

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      expected_response = %{
        email: ["has invalid format"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
