defmodule HackNewsBackendWeb.ChallengeControllerTest do
  use HackNewsBackendWeb.ConnCase, async: true
  import HackNewsBackend.Factory

  alias HackNewsBackend.{User, Repo}

  describe "index/2" do
    test "returns list of challenges", %{conn: conn} do
      [challenge1, challenge2] = insert_pair(:challenge)

      response =
        conn
        |> get_authenticated_session()
        |> get(Routes.api_challenge_path(conn, :index))
        |> json_response(200)

      assert %{"title" => challenge1.title, "description" => challenge1.description} in response
      assert %{"title" => challenge2.title, "description" => challenge2.description} in response
    end
  end

  describe "create/2" do
    test "store challenge", %{conn: conn} do
      params = string_params_for(:challenge)

      conn
      |> get_authenticated_session()
      |> post(Routes.api_challenge_path(conn, :create), params)
      |> json_response(200)

      response =
        conn
        |> get_authenticated_session()
        |> get(Routes.api_challenge_path(conn, :index))
        |> json_response(200)

      assert params in response
    end
  end

  defp get_authenticated_session(conn) do
    user_params = %{"name" => "Booda", "email" => "booda@booda.com", "password" => "aaa"}
    case User |> Repo.get_by(name: "Booda") do
      nil -> User.create_user(user_params)
      user -> user
    end
    %{"jwt" => jwt} = conn |> post(Routes.api_session_path(conn, :sign_in), %{"user" => user_params}) |> json_response(200)
    conn |> put_req_header("authorization", "Bearer #{jwt}")
  end
end
