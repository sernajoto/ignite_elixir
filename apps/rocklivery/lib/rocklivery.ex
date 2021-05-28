defmodule Rocklivery do
  alias Rocklivery.Users.Create, as: UserCreate
  alias Rocklivery.Users.Delete, as: UserDelete
  alias Rocklivery.Users.Get, as: UserGet
  alias Rocklivery.Users.Update, as: UserUpdate

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
  defdelegate update_user(params), to: UserUpdate, as: :call
end
