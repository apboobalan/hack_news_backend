defmodule HackNewsBackendWeb.ChallengeControllerTest do
  use HackNewsBackendWeb.ConnCase, async: true
  import HackNewsBackend.Factory

  alias HackNewsBackend.{User, Repo}

  defp insert_challenge_api(conn) do
    params = string_params_for(:challenge)

    conn
    |> get_authenticated_session()
    |> post(Routes.api_challenge_path(conn, :create), params)
    |> json_response(200)
    params
  end

  describe "index/2" do
    test "returns list of challenges", %{conn: conn} do
      challenge1 = insert_challenge_api(conn)
      challenge2 = insert_challenge_api(conn)

      response =
        conn
        |> get_authenticated_session()
        |> get(Routes.api_challenge_path(conn, :index))
        |> json_response(200)
        titles = response |> Enum.map(& &1["title"])
        descriptions = response |> Enum.map(& &1["description"])
      assert challenge1["title"] in titles
      assert challenge2["title"] in titles
      assert challenge1["description"] in descriptions
      assert challenge2["description"] in descriptions
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

        titles = response |> Enum.map(& &1["title"])
        descriptions = response |> Enum.map(& &1["description"])

        assert params["title"] in titles
        assert params["description"] in descriptions
    end

    test "store challenge with tags", %{conn: conn} do
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
        titles = response |> Enum.map(& &1["title"])
        descriptions = response |> Enum.map(& &1["description"])
        tags = response |> Enum.flat_map(& &1["tags"]) |> Enum.map(& &1["name"])
        assert params["title"] in titles
        assert params["description"] in descriptions
        assert (params["tags"] |> List.first |> Map.get("name")) in tags
        assert (params["tags"] |> Enum.at(1) |> Map.get("name")) in tags
    end
  end

  defp get_authenticated_session(conn) do
    user_params = %{"name" => "Booda", "email" => "booda@booda.com", "password" => "aaa"}

    case User |> Repo.get_by(name: "Booda") do
      nil -> User.create_user(user_params)
      user -> user
    end

    %{"jwt" => jwt} =
      conn
      |> post(Routes.api_session_path(conn, :sign_in), %{"user" => user_params})
      |> json_response(200)

    conn |> put_req_header("authorization", "Bearer #{jwt}")
  end
end
