defmodule HackNewsBackendWeb.ChallengeView do
  use HackNewsBackendWeb, :view

  def render("challenges.json", %{challenges: challenges}) do
    render_many(challenges, HackNewsBackendWeb.ChallengeView, "challenge.json")
  end

  def render("challenge.json", %{challenge: challenge}) do
    %{
      title: challenge.title,
      description: challenge.description,
      tags: render_many(challenge.tags, HackNewsBackendWeb.TagView, "tag.json")
    }
  end
end
