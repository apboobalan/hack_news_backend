defmodule HackNewsBackend.HackNewsBackend.Challenge do
  use Ecto.Schema
  import Ecto.Changeset
  alias HackNewsBackend.HackNewsBackend.Tag
  alias HackNewsBackend.Repo

  schema "challenges" do
    field :description, :string
    field :title, :string
    many_to_many :tags, Tag, join_through: "challenges_tags"
    belongs_to :created, HackNewsBackend.User
    has_many :teams, HackNewsBackend.HackNewsBackend.Team
    many_to_many :users, HackNewsBackend.User, join_through: "users_challenges_votings"

    timestamps()
  end

  @doc false
  def changeset(challenge, attrs) do
    challenge
    |> cast(attrs, [:title, :description, :created_id])
    |> validate_required([:title, :description, :created_id])
    |> put_assoc(:tags, parse_tags(attrs))
  end

  defp parse_tags(params) do
    (params["tags"] || [])
    |> Enum.map(& &1["name"])
    |> Enum.map(&get_or_insert_tag/1)
  end

  def all() do
    __MODULE__ |> Repo.all() |> Repo.preload([:tags, :created, :users])
  end

  def get_detail(id) do
    __MODULE__ |> Repo.get!(id) |> Repo.preload([:tags, :created, {:teams, :users}, :users])
  end

  defp get_or_insert_tag(name) do
    Repo.insert!(%Tag{name: name}, on_conflict: [set: [name: name]], conflict_target: :name)
  end
end
