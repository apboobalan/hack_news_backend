defmodule HackNewsBackend.Repo.Migrations.AlterChallengesAddUserId do
  use Ecto.Migration

  def change do
    alter table(:challenges) do
      add :created_id, references(:users)
    end
  end
end
