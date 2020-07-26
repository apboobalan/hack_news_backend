defmodule HackNewsBackendWeb.SessionViewTest do
  use HackNewsBackendWeb.ConnCase, async: true

  import Phoenix.View

  test "renders user.json" do
    assert %{name: "Booda", email: "booda@booda.com"} =
             render(HackNewsBackendWeb.SessionView, "user.json",
               user: %{name: "Booda", email: "booda@booda.com"}
             )
  end

  test "renders session_error.json" do
    assert %{message: "error message"} =
             render(HackNewsBackendWeb.SessionView, "session_error.json", message: "error message")
  end
end
