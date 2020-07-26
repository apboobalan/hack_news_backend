defmodule HackNewsBackendWeb.SessionController do
  use HackNewsBackendWeb, :controller
  alias HackNewsBackend.User
  def sign_in(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case User.find_and_validate_password(email, password) do
      {:ok, user} ->
        conn |> render("user.json", user: user)

      {:error, :invalid} ->
        conn |> render("session_error.json", message: "Either name or password is incorrect.")
    end
  end
end
