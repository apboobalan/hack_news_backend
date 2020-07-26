defmodule HackNewsBackend.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :challenge_id, references(:challenges)

      timestamps()
    end

    create unique_index(:teams, [:name, :challenge_id])
  end
end
