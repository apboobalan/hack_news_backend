defmodule HackNewsBackendWeb.SessionView do
  use HackNewsBackendWeb, :view

  def render("user.json", %{user: user}) do
    %{
      name: user.name,
      email: user.email
    }
  end

  def render("session_error.json", %{message: message}) do
    %{
      message: message
    }
  end
end
