defmodule HackNewsBackendWeb.SessionViewTest do
  use HackNewsBackendWeb.ConnCase, async: true

  import Phoenix.View

  test "renders user.json" do
    assert %{name: "Booda", email: "booda@booda.com", jwt: "it'sajwt"} =
             render(HackNewsBackendWeb.SessionView, "user_with_jwt.json",
               %{user: %{name: "Booda", email: "booda@booda.com"}, jwt: "it'sajwt"}
             )
  end

  test "renders session_error.json" do
    assert %{message: "error message"} =
             render(HackNewsBackendWeb.SessionView, "session_error.json", message: "error message")
  end
end
