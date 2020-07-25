defmodule HackNewsBackend.Repo.Migrations.CreateChallenges do
  use Ecto.Migration

  def change do
    create table(:challenges) do
      add :title, :string
      add :description, :string

      timestamps()
    end

  end
end
