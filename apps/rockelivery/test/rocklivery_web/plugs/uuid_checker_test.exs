defmodule RockeliveryWeb.Plugs.UUIDCheckerTest do
  use RockeliveryWeb.ConnCase, async: true

  alias RockeliveryWeb.Plugs.UUIDChecker

  describe "init/1" do
    test "when given the options, return the options" do
      response = UUIDChecker.init(%{options: true})

      assert response == %{options: true}
    end
  end

  describe "call/2" do
    test "when it receives a conn with a valid UUID, return the conn", %{conn: conn} do
      id = "249a7ca0-0442-4eab-a574-445d8e1005dc"

      request_conn =
        conn
        |> Map.put(:params, %{"id" => id})

      response = UUIDChecker.call(request_conn, %{})

      assert response == request_conn
    end

    test "when it receives a conn with a invalid UUID, returns an error", %{conn: conn} do
      id = "249a7ca0-0442"

      request_conn =
        conn
        |> Map.put(:params, %{"id" => id})

      response =
        UUIDChecker.call(request_conn, %{})
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid UUID"}

      assert response == expected_response
    end

    test "when it receives a conn without UUID, return the conn", %{conn: conn} do
      response = UUIDChecker.call(conn, %{})

      assert response == conn
    end
  end
end
