defmodule HackNewsBackendWeb.TagView do
  use HackNewsBackendWeb, :view

  def render("tag.json", %{tag: tag}) do
    %{name: tag.name}
  end
end
