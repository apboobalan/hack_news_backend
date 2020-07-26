defmodule HackNewsBackendWeb.RegistrationView do
  use HackNewsBackendWeb, :view

  def render("user_with_jwt.json", assigns) do
    render(HackNewsBackendWeb.SessionView, "user_with_jwt.json", assigns)
  end
end
