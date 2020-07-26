defmodule HackNewsBackendWeb.RegistrationControllerTest do
  use HackNewsBackendWeb.ConnCase, async: true

  alias HackNewsBackend.{Repo, User}

  describe "sign_up/2" do
    test "create user", %{conn: conn} do
      user_params = %{"name" => "Booda", "email" => "booda@booda.com", "password" => "aaa"}

      response =
        conn
        |> post(Routes.api_registration_path(conn, :sign_up), %{"user" => user_params})
        |> json_response(200)

      user = User |> Repo.get_by!(name: user_params["name"])

      assert response["email"]
      assert response["name"]
      assert response["jwt"]
      assert user.name == user_params["name"]
      assert user.email == user_params["email"]
    end
  end
end
