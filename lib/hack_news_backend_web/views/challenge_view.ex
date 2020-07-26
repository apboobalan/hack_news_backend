defmodule HackNewsBackendWeb.ChallengeView do
  use HackNewsBackendWeb, :view

  def render("challenges.json", %{challenges: challenges}) do
    render_many(challenges, HackNewsBackendWeb.ChallengeView, "challenge.json")
  end

  def render("challenge.json", %{challenge: challenge}) do
    %{
      id: challenge.id,
      title: challenge.title,
      description: challenge.description,
      tags: render_many(challenge.tags, HackNewsBackendWeb.TagView, "tag.json"),
      user: render_one(challenge.user, HackNewsBackendWeb.UserView, "user.json")
    }
  end

  def render("challenge_detail.json", %{challenge_detail: challenge_detail}) do
    %{
      id: challenge_detail.id,
      title: challenge_detail.title,
      description: challenge_detail.description,
      tags: render_many(challenge_detail.tags, HackNewsBackendWeb.TagView, "tag.json"),
      user: render_one(challenge_detail.user, HackNewsBackendWeb.UserView, "user.json"),
      teams: render_many(challenge_detail.teams, HackNewsBackendWeb.TeamView, "team.json")
    }
  end
end
