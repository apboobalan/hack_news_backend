defmodule HackNewsBackend.TeamTest do
  use HackNewsBackend.DataCase, async: true
  alias HackNewsBackend.HackNewsBackend.{Team}
  alias HackNewsBackend.Repo
  import HackNewsBackend.Factory

  describe "add_team/1" do
    test "Add team to a challenge" do
      challenge = insert(:challenge)
      team_params = %{"name" => "Alpha", "challenge_id" => challenge.id}

      Team.add_team(team_params)

      team = Team |> Repo.get_by!(name: team_params["name"], challenge_id: team_params["challenge_id"])

      assert team.name == team_params["name"]
      assert team.challenge_id == team_params["challenge_id"]
    end

    test "get_team/1" do
      expected_team = insert(:team)
      team_params = %{"name" => expected_team.name, "challenge_id" => expected_team.challenge_id}

      team = Team.get_team(team_params)

      assert team.name == expected_team.name
      assert team.challenge_id == expected_team.challenge_id
    end
  end
end
