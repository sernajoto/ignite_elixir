defmodule Exmeal.Users.CreateTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.{Error, User}
  alias Exmeal.Users.Create

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      response = Create.call(params)

      assert {:ok, %User{id: _id, name: "Guilherme", cpf: "11111111111", email: "gui@test.com"}} =
               response
    end

    test "when there are invalid params, returns an error" do
      params = build(:user_params, %{email: "mail"})

      response = Create.call(params)

      expected_response = %{
        email: ["has invalid format"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response

      assert errors_on(changeset) == expected_response
    end
  end
end
