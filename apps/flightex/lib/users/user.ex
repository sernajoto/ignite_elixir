defmodule Flightex.Users.User do
  @keys [:id, :name, :email, :cpf]

  @enforce_keys @keys
  defstruct @keys

  def build(name, email, cpf) when is_bitstring(cpf) do
    uuid = UUID.uuid4()
    {:ok, %__MODULE__{id: uuid, name: name, email: email, cpf: cpf}}
  end

  def build(_name, _email, _cpf), do: {:error, "Invalid parameters"}
end
