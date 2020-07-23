defmodule HackNewsBackendWeb.PageController do
  use HackNewsBackendWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
