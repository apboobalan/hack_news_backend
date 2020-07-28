defmodule HackNewsBackendWeb.ChallengeViewTest do
  use HackNewsBackendWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders challenge.json" do
    assert %{
             id: 1,
             title: "challenge 1",
             description: "challenge 1 description.",
             created: %{name: "a", email: "a"},
             voted: [],
             votes: 0,
             enableUpvote: true
           } =
             render(HackNewsBackendWeb.ChallengeView, "challenge.json",
               challenge: %{
                 id: 1,
                 title: "challenge 1",
                 description: "challenge 1 description.",
                 tags: [],
                 created: %{name: "a", email: "a"},
                 users: []
               },
               user: %{name: "a", email: "email"}
             )
  end

  test "renders challenges.json" do
    [challenge1, challenge2] = [
      %{
        id: 1,
        title: "challenge 1",
        description: "challenge 1 description",
        tags: [],
        created: %{email: "a", name: "a"},
        users: []
      },
      %{
        id: 2,
        title: "challenge 1",
        description: "challenge 1 description",
        tags: [],
        created: %{email: "a", name: "a"},
        users: []
      }
    ]

    [expected1, _expected2] = [
      %{
        created: %{email: "a", name: "a"},
        description: "challenge 1 description",
        enableUpvote: false,
        id: 1,
        tags: [],
        title: "challenge 1",
        voted: [],
        votes: 0
      },
      %{
        created: %{email: "a", name: "a"},
        description: "challenge 1 description",
        enableUpvote: false,
        id: 2,
        tags: [],
        title: "challenge 1",
        voted: [],
        votes: 0
      }
    ]

    assert expected1 in render(HackNewsBackendWeb.ChallengeView, "challenges.json",
             challenges: [challenge1, challenge2],
             user: %{email: "a"}
           )
  end

  test "return true if the challenge is not created by user and he has not already voted" do
    challenge = %{users: [%{email: "a"}, %{email: "b"}], created: %{email: "c"}}
    user = %{email: "d"}
    assert HackNewsBackendWeb.ChallengeView.enable_upvote?(challenge, user)
  end

  test "return false if the challenge is created by user" do
    challenge = %{users: [%{email: "a"}, %{email: "b"}], created: %{email: "c"}}
    user = %{email: "c"}
    refute HackNewsBackendWeb.ChallengeView.enable_upvote?(challenge, user)
  end

  test "return false if user has already voted" do
    challenge = %{users: [%{email: "a"}, %{email: "b"}], created: %{email: "c"}}
    user = %{email: "a"}
    refute HackNewsBackendWeb.ChallengeView.enable_upvote?(challenge, user)
  end
end
