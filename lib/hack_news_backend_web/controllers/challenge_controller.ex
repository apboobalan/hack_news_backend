defmodule HackNewsBackendWeb.ChallengeController do
  use HackNewsBackendWeb, :controller

  alias HackNewsBackend.HackNewsBackend.Challenge
  alias HackNewsBackend.Repo

  def index(conn, _params) do
    challenges = Challenge.all()
    conn |> render("challenges.json", challenges: challenges)
  end

  def create(conn, params) do
    user = Guardian.Plug.current_resource(conn)
    %Challenge{} |> Challenge.changeset(params |> Map.put("created_id", user.id)) |> Repo.insert
    conn |> json(%{status: :ok})
  end

  def show(conn, %{"id" => id}) do
    challenge_detail = Challenge.get_detail(id)
    conn |> render("challenge_detail.json", challenge_detail: challenge_detail)
  end
end
