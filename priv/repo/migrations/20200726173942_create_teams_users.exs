defmodule HackNewsBackend.Repo.Migrations.CreateTeamsUsers do
  use Ecto.Migration

  def change do
    create table(:teams_users, primary_key: false) do
      add :team_id, references(:teams)
      add :user_id, references(:users)

      timestamps()
    end

    create unique_index(:teams_users, [:team_id, :user_id])
  end
end
