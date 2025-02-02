defmodule HackNewsBackendWeb.SessionController do
  use HackNewsBackendWeb, :controller
  alias HackNewsBackend.{User, Auth}

  def sign_in(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case User.find_and_validate_password(email, password) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = Auth.Authenticaton.encode_and_sign(user)
        conn |> render("user_with_jwt.json", user: user, jwt: jwt)

      {:error, :invalid} ->
        conn |> put_status(400) |> json(%{status: :error})
    end
  end
end
