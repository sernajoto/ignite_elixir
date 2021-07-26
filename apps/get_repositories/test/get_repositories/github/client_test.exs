defmodule GetRepositories.Github.ClientTest do
  use ExUnit.Case, async: true

  alias GetRepositories.Error
  alias GetRepositories.Github.Client
  alias Plug.Conn

  describe "get_user_repositories/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is a valid username, returns your repositories infos", %{bypass: bypass} do
      username = "sernajoto"

      url = endpoint_url(bypass.port)

      body = ~s([
        {
          "description": "Challenge Elixir Stone",
          "html_url": "https://github.com/sernajoto/challenge-elixir-stone",
          "id": 339279208,
          "name": "challenge-elixir-stone",
          "stargazers_count": 1
        },
        {
          "description": "Testing GraphQL",
          "html_url": "https://github.com/sernajoto/cloud-graphql",
          "id": 145048807,
          "name": "cloud-graphql",
          "stargazers_count": 1
        }
      ])

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_user_repositories(url, username)

      expected_response =
        {:ok,
         [
           %{
             description: "Challenge Elixir Stone",
             html_url: "https://github.com/sernajoto/challenge-elixir-stone",
             id: 339_279_208,
             name: "challenge-elixir-stone",
             stargazers_count: 1
           },
           %{
             description: "Testing GraphQL",
             html_url: "https://github.com/sernajoto/cloud-graphql",
             id: 145_048_807,
             name: "cloud-graphql",
             stargazers_count: 1
           }
         ]}

      assert response == expected_response
    end

    test "when some other error occurs, returns an error", %{bypass: bypass} do
      username = "sernajoto"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        Conn.resp(conn, 403, "")
      end)

      response = Client.get_user_repositories(url, username)

      expected_response = {:error, %Error{result: "There was a problem!", status: 403}}

      assert response == expected_response
    end

    test "when the username was not found, returns an error", %{bypass: bypass} do
      username = "notfound"

      url = endpoint_url(bypass.port)

      body = ~s({"message": "Not Found"})

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(404, body)
      end)

      response = Client.get_user_repositories(url, username)

      expected_response = {:error, %Error{result: "User not found!", status: :not_found}}

      assert response == expected_response
    end

    test "when there is a generic error, returns an error", %{bypass: bypass} do
      username = "sernajoto"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_user_repositories(url, username)

      expected_response = {:error, %Error{result: :econnrefused, status: :bad_request}}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
