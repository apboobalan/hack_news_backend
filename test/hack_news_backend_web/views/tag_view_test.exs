defmodule HackNewsBackendWeb.TagViewTest do
  use HackNewsBackendWeb.ConnCase, async: true

  import Phoenix.View

  test "renders tag.json" do
    assert %{name: "tag 1"} = render(HackNewsBackendWeb.TagView, "tag.json", tag: %{name: "tag 1"})
  end
end
