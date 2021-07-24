defmodule Exmeal do
  alias Exmeal.Meals.Create, as: MealCreate
  alias Exmeal.Meals.Delete, as: MealDelete
  alias Exmeal.Meals.Get, as: MealGet
  alias Exmeal.Meals.Update, as: MealUpdate

  alias Exmeal.Users.Create, as: UserCreate
  alias Exmeal.Users.Delete, as: UserDelete
  alias Exmeal.Users.Get, as: UserGet
  alias Exmeal.Users.Update, as: UserUpdate

  defdelegate create_meal(params), to: MealCreate, as: :call
  defdelegate delete_meal(id), to: MealDelete, as: :call
  defdelegate get_meal_by_id(id), to: MealGet, as: :by_id
  defdelegate update_meal(params), to: MealUpdate, as: :call

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
  defdelegate update_user(params), to: UserUpdate, as: :call
end
