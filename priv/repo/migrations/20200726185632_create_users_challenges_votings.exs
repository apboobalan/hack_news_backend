defmodule HackNewsBackend.Repo.Migrations.CreateUsersChallengesVotings do
  use Ecto.Migration

  def change do
    create table(:users_challenges_votings, primary_key: false) do
      add :user_id, references(:users)
      add :challenge_id, references(:challenges)

      timestamps()
    end

    create unique_index(:users_challenges_votings, [:user_id, :challenge_id])
  end
end
