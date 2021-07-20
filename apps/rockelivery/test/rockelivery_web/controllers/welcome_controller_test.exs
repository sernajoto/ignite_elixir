defmodule RockeliveryWeb.WelcomeControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  describe "index/2" do
    test "should render Welcome text", %{conn: conn} do
      response =
        conn
        |> get(Routes.welcome_path(conn, :index))
        |> response(:ok)

      assert response == "Welcome!"
    end
  end
end
