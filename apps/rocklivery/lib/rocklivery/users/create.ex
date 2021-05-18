defmodule Rocklivery.Users.Create do
  alias Rocklivery.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
