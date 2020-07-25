defmodule HackNewsBackendWeb.ChallengeController do
  use HackNewsBackendWeb, :controller

  alias HackNewsBackend.HackNewsBackend.Challenge
  alias HackNewsBackend.Repo

  def index(conn, _params) do
    challenges = Challenge |> Repo.all()

    conn |> json(challenges)
  end
end
