defmodule GetRepositoriesWeb.Auth.Guardian do
  use Guardian, otp_app: :get_repositories

  alias GetRepositories.{Error, User}
  alias Plug.Conn

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> GetRepositories.get_user_by_id()
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- GetRepositories.get_user_by_id(user_id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user, %{}, ttl: {1, :minute}) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}

  def refresh_token(%Conn{} = conn) do
    conn
    |> Conn.get_req_header("authorization")
    |> get_token()
    |> gen_new_token()
  end

  defp get_token([bearer_token]), do: String.split(bearer_token, " ")

  defp gen_new_token([_bearer, token]) do
    {:ok, _old_stuff, {new_token, _new_claims}} = refresh(token, ttl: {1, :minute})

    {:ok, new_token}
  end
end
