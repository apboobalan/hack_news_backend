defmodule HackNewsBackendWeb.ChallengeControllerTest do
  use HackNewsBackendWeb.ConnCase, async: true
  import HackNewsBackend.Factory

  describe "index/2" do
    test "returns list of challenges", %{conn: conn} do
      [challenge1, challenge2] = insert_pair(:challenge)

      response =
        conn
        |> get(Routes.challenge_path(conn, :index))
        |> json_response(200)

      assert %{"title" => challenge1.title, "description" => challenge1.description} in response
      assert %{"title" => challenge2.title, "description" => challenge2.description} in response
    end
  end

  describe "create/2" do
    test "store challenge", %{conn: conn} do
      params = string_params_for(:challenge)

      conn
      |> post(Routes.challenge_path(conn, :create), params)
      |> json_response(200)

      response =
        conn
        |> get(Routes.challenge_path(conn, :index))
        |> json_response(200)

      assert params in response
    end
  end
end
