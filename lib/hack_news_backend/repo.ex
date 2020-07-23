defmodule HackNewsBackend.Repo do
  use Ecto.Repo,
    otp_app: :hack_news_backend,
    adapter: Ecto.Adapters.Postgres
end
