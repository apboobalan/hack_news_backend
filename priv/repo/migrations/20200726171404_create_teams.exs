defmodule HackNewsBackend.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :challenge_id, references(:challenges)

      timestamps()
    end
  end
end
