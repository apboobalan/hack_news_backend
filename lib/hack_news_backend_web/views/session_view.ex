defmodule HackNewsBackendWeb.SessionView do
  use HackNewsBackendWeb, :view

  def render("user_with_jwt.json", %{user: user, jwt: jwt}) do
    %{
      name: user.name,
      email: user.email,
      jwt: jwt
    }
  end

  def render("session_error.json", %{message: message}) do
    %{
      message: message
    }
  end
end
