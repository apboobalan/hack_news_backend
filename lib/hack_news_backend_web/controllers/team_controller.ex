defmodule HackNewsBackendWeb.TeamController do
  use HackNewsBackendWeb, :controller

  alias HackNewsBackend.HackNewsBackend.{Team, TeamsUsers}

  def create(conn, params) do
    case Team.get_team(params) do
      nil ->
        Team.add_team(params)
        conn |> json(%{status: :ok})

      _team ->
        conn |> json(%{status: :error, message: :already_added})
    end
  end

  def add_user_to_team(conn, params) do
    user = Guardian.Plug.current_resource(conn)
    team = Team.get_team(params)
    TeamsUsers.add_user_to_team(user, team)
    conn |> json(%{status: :ok})
  end
end
