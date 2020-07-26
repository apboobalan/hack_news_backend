defmodule HackNewsBackendWeb.TeamController do
  use HackNewsBackendWeb, :controller

  alias HackNewsBackend.HackNewsBackend.{Team, TeamsUsers}

  def create(conn, params) do
    case Team.add_team(params) do
      {:ok, _team} ->
        conn |> json(%{status: :ok})

      {:error, _changeset} ->
        conn |> json(%{status: :error, message: "already_taken"})
    end
  end

  def add_user_to_team(conn, params) do
    user = Guardian.Plug.current_resource(conn)
    team = Team.get_team(params)

    case TeamsUsers.add_user_to_team(user, team) do
      {:error, _} -> conn |> json(%{status: :error, message: :already_added})
      {:ok, _} -> conn |> json(%{status: :ok})
    end
  end
end
