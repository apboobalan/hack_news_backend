defmodule HackNewsBackend.HackNewsBackend.TeamsUsers do
  use Ecto.Schema
  import Ecto.Changeset
  alias HackNewsBackend.Repo

  @primary_key false
  schema "teams_users" do
    belongs_to :user, HackNewsBackend.User
    belongs_to :team, HackNewsBackend.HackNewsBackend.Team

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:team_id, :user_id])
    |> validate_required([:team_id, :user_id])
    |> unique_constraint([:team_id, :user_id])
  end

  def add_user_to_team(user, team) do
    %__MODULE__{}
    |> changeset(%{"user_id" => user.id, "team_id" => team.id})
    |> Repo.insert()
  end
end
