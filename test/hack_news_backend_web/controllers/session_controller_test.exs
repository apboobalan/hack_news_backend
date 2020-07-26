defmodule HackNewsBackendWeb.SessionControllerTest do
  use HackNewsBackendWeb.ConnCase, async: true

  alias HackNewsBackend.{User, Repo}

  describe "sign_in/2" do
    test "return user details after successful sign in.", %{conn: conn} do
      user_params = %{"name" => "Booda", "email" => "booda@booda.com", "password" => "aaa"}
      User.create_user(user_params)

      response =
        conn
        |> post(Routes.api_session_path(conn, :sign_in), %{"user" => user_params})
        |> json_response(200)

      assert %{"status" => "ok", "user" => user} = response
      assert user.name == user_params["name"]
      assert user.email == user_params["email"]
    end
  end
end
