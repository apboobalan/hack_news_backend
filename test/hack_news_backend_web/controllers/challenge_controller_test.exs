defmodule HackNewsBackendWeb.ChallengeControllerTest do
  use HackNewsBackendWeb.ConnCase, async: true
  import HackNewsBackend.Factory

  describe "index/2" do
    test "returns list of challenges", %{conn: conn} do
      insert_pair(:challenge)

      response =
        conn
        |> get(Routes.challenge_path(conn, :index))
        |> json_response(200)

      assert response == [
               %{"title" => "challenge 0", "description" => "challenge 0 description"},
               %{"title" => "challenge 1", "description" => "challenge 1 description"}
             ]
    end
  end
end
