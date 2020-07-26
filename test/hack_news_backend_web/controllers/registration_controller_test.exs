defmodule HackNewsBackendWeb.RegistrationControllerTest do
  use HackNewsBackendWeb.ConnCase, async: true
  import HackNewsBackend.Factory

  alias HackNewsBackend.Repo

  describe "sign_up/2" do
    test "create user", %{conn: conn} do
      user_params = %{"name" => "Booda", "email" => "booda@booda.com", "password" => "aaa"}

      response =
        conn
        |> post(Routes.api_registration_path(conn, :sign_up), %{"user" => user_params})
        |> json_response(200)

      user = User |> Repo.get!(name: user_params["name"])

      assert %{status: :ok} = response
      assert user.name == user_params["name"]
      assert user.email == user_params["email"]
    end
  end
end
