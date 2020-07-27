defmodule HackNewsBackendWeb.ChallengeController do
  use HackNewsBackendWeb, :controller

  alias HackNewsBackend.HackNewsBackend.Challenge
  alias HackNewsBackend.Repo

  def index(conn, params) do
    user = Guardian.Plug.current_resource(conn)
    challenges = Challenge.all() |> sort(params)
    conn |> render("challenges.json", challenges: challenges, user: user)
  end

  def create(conn, params) do
    user = Guardian.Plug.current_resource(conn)
    %Challenge{} |> Challenge.changeset(params |> Map.put("created_id", user.id)) |> Repo.insert()
    conn |> json(%{status: :ok})
  end

  def show(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    challenge_detail = Challenge.get_detail(id)
    conn |> render("challenge_detail.json", challenge_detail: challenge_detail, user: user)
  end

  defp sort(challenges, %{"sort" => "votes"}) do
    votes = fn challenge -> challenge.users |> Enum.count() end
    challenges |> Enum.sort_by(votes, :desc)
  end

  defp sort(challenges, %{"sort" => "created"}) do
    created = fn challenge -> challenge.inserted_at end
    challenges |> Enum.sort_by(created, :desc)
  end

  defp sort(challenges, %{}), do: challenges
end
