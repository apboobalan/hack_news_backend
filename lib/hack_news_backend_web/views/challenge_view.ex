defmodule HackNewsBackendWeb.ChallengeView do
  use HackNewsBackendWeb, :view

  def render("challenges.json", %{challenges: challenges, user: user}) do
    render_many(challenges, HackNewsBackendWeb.ChallengeView, "challenge.json", user: user)
  end

  def render("challenge.json", %{challenge: challenge, user: user}) do
    %{
      id: challenge.id,
      title: challenge.title,
      description: challenge.description,
      tags: render_many(challenge.tags, HackNewsBackendWeb.TagView, "tag.json"),
      created: render_one(challenge.created, HackNewsBackendWeb.UserView, "created.json"),
      voted: render_many(challenge.users, HackNewsBackendWeb.UserView, "user.json"),
      votes: challenge.users |> Enum.count,
      enableUpvote: enable_upvote?(challenge, user)
    }
  end

  def render("challenge_detail.json", %{challenge_detail: challenge_detail, user: user}) do
    %{
      id: challenge_detail.id,
      title: challenge_detail.title,
      description: challenge_detail.description,
      tags: render_many(challenge_detail.tags, HackNewsBackendWeb.TagView, "tag.json"),
      created: render_one(challenge_detail.created, HackNewsBackendWeb.UserView, "created.json"),
      teams: render_many(challenge_detail.teams, HackNewsBackendWeb.TeamView, "team.json"),
      voted: render_many(challenge_detail.users, HackNewsBackendWeb.UserView, "user.json"),
      votes: challenge_detail.users |> Enum.count,
      enableUpvote: enable_upvote?(challenge_detail, user)
    }
  end

  defp enable_upvote?(challenge, user) do
    already_voted_users = challenge.users |> Enum.map(& &1.email)
    created_by_user = challenge.created.email
    non_eligible_voters = [created_by_user | already_voted_users] |> Enum.uniq()

    !(user.email in non_eligible_voters)
  end
end
