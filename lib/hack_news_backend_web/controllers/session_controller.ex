defmodule HackNewsBackendWeb.SessionController do
  use HackNewsBackendWeb, :controller

  def sign_in(conn, %{"user" => %{"email" => email, "password" => password}}) do
    user = User.find_and_confirm_password(email, password)
    conn |> json(%{status: :ok, user: %{name: user.name, email: user.email}})
  end
end
