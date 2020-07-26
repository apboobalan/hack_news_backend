defmodule HackNewsBackendWeb.TeamController do
  use HackNewsBackendWeb, :controller

  alias HackNewsBackend.HackNewsBackend.Team

  def create(conn, params) do
    case Team.get_team(params) do
      nil ->
        Team.add_team(params)
        conn |> json(%{status: :ok})
      _team -> conn |> json(%{status: :error, message: :already_added})
    end
  end
end
