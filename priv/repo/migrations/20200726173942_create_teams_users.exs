defmodule HackNewsBackend.Repo.Migrations.CreateTeamsUsers do
  use Ecto.Migration

  def change do
    create table(:teams_users, primary_key: false) do
      add :team_id, references(:teams)
      add :user_id, references(:users)

      timestamps()
    end
  end
end
