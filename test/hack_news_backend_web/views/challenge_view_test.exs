defmodule HackNewsBackendWeb.ChallengeViewTest do
  use HackNewsBackendWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders challenge.json" do
    assert %{title: "challenge 1", description: "challenge 1 description."} = render(HackNewsBackendWeb.ChallengeView, "challenge.json", challenge: %{title: "challenge 1", description: "challenge 1 description.", tags: []})
  end

test "renders challenges.json" do
  [challenge1, challenge2] = [%{title: "challenge 1", description: "challenge 1 description", tags: []}, %{title: "challenge 1", description: "challenge 1 description", tags: []}]
  assert challenge1 in render(HackNewsBackendWeb.ChallengeView, "challenges.json", challenges: [challenge1, challenge2])
end
end
