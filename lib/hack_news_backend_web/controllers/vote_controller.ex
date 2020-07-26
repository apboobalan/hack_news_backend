defmodule HackNewsBackendWeb.VoteController do
  use HackNewsBackendWeb, :controller
  alias HackNewsBackend.HackNewsBackend.UsersChallengesVotings

  def vote(conn, params) do
    user = Guardian.Plug.current_resource(conn)

    try do
      UsersChallengesVotings.vote_challenge(params |> Map.put("user_id", user.id))
      conn |> json(%{status: :ok})
    rescue
      _ -> conn |> json(%{status: :error, messaage: :already_voted})
    end
  end
end
