defmodule HackNewsBackend.Repo.Migrations.AlterChallengesAddUserId do
  use Ecto.Migration

  def change do
    alter table(:challenges) do
      add :user_id, references(:users)
    end
  end
end
