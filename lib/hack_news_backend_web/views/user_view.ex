defmodule HackNewsBackendWeb.UserView do
  use HackNewsBackendWeb, :view

  def render("user.json", %{user: user}) do
    %{
      name: user.name,
      email: user.email
    }
  end

  def render("created.json", %{user: user}) do
    %{
      name: user.name,
      email: user.email
    }
  end
end
