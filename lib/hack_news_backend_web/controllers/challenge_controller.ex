defmodule HackNewsBackendWeb.ChallengeController do
  use HackNewsBackendWeb, :controller

  alias HackNewsBackend.HackNewsBackend.Challenge
  alias HackNewsBackend.Repo

  def index(conn, _params) do
    challenges = Challenge.all()
    conn |> render("challenges.json", challenges: challenges)
  end

  def create(conn, params) do
    %Challenge{} |> Challenge.changeset(params) |> Repo.insert
    conn |> json(%{status: :ok})
  end
end
