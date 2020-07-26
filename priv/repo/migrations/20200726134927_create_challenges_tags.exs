defmodule HackNewsBackend.Repo.Migrations.CreateChallengesTags do
  use Ecto.Migration

  def change do
    create table(:challenges_tags, primary_key: false) do
      add :challenge_id, references(:challenges)
      add :tag_id, references(:tags)
    end
  end
end
