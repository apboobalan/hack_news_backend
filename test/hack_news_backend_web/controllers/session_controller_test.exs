defmodule HackNewsBackendWeb.SessionControllerTest do
  use HackNewsBackendWeb.ConnCase, async: true

  alias HackNewsBackend.{User}

  describe "sign_in/2" do
    test "return user details after successful sign in.", %{conn: conn} do
      user_params = %{"name" => "Booda", "email" => "booda@booda.com", "password" => "aaa"}
      User.create_user(user_params)

      user =
        conn
        |> post(Routes.api_session_path(conn, :sign_in), %{"user" => user_params})
        |> json_response(200)

      assert user["name"] == user_params["name"]
      assert user["email"] == user_params["email"]
    end

    test "return error when user details for sign in are incorrect", %{conn: conn} do
      user_params = %{"name" => "Booda", "email" => "booda@booda.com", "password" => "aaa"}
      User.create_user(user_params)
      invalid_user_params = %{"email" => "booda@booda.com", "password" => "bbb"}

      response =
        conn
        |> post(Routes.api_session_path(conn, :sign_in), %{"user" => invalid_user_params})
        |> json_response(200)

      assert %{ "message" => "Either name or password is incorrect."} == response
    end
  end
end
