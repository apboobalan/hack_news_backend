defmodule HackNewsBackendWeb.RegistrationController do
  use HackNewsBackendWeb, :controller

  alias HackNewsBackend.{User, Auth}

  def sign_up(conn, %{"user" => user}) do
    case User.create_user(user) do
      {:error, _changeset} ->
        conn |> put_status(400) |> json(%{status: :error})

      {:ok, user} ->
        {:ok, jwt, _full_claims} = Auth.Authenticaton.encode_and_sign(user)
        conn |> render("user_with_jwt.json", %{user: user, jwt: jwt})
    end
  end
end
