defmodule HackNewsBackendWeb.TeamView do
  use HackNewsBackendWeb, :view


  def render("team.json", %{team: team}) do
    %{
      name: team.name,
      users: render_many(team.users, HackNewsBackendWeb.UserView, "user.json"),
    }
  end
end
