defmodule HackNewsBackendWeb.RegistrationController do
  use HackNewsBackendWeb, :controller

  alias HackNewsBackend.User
  def sign_up(conn, %{"user" => user}) do
    user = User.create_user(user)
    conn |> json(%{status: :ok, user: user})
  end
end
