defmodule HackNewsBackend.HackNewsBackend.Team do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias HackNewsBackend.Repo

  schema "teams" do
    field :name, :string
    belongs_to :challenge, HackNewsBackend.HackNewsBackend.Challenge
    many_to_many :users, HackNewsBackend.User, join_through: "teams_users"

    timestamps()
  end

  @doc false
  def changeset(challenge, attrs) do
    challenge
    |> cast(attrs, [:name, :challenge_id])
    |> validate_required([:name, :challenge_id])
  end

  def add_team(params) do
    %__MODULE__{} |> changeset(params) |> Repo.insert!()
  end

  def get_team(params) do
    %{"name" => name, "challenge_id" => challenge_id} = params

    from(t in __MODULE__, where: t.name == ^name and t.challenge_id == ^challenge_id)
    |> Repo.one()
  end
end
