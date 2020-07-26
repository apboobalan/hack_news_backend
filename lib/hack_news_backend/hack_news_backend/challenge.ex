defmodule HackNewsBackend.HackNewsBackend.Challenge do
  use Ecto.Schema
  import Ecto.Changeset
  alias HackNewsBackend.HackNewsBackend.Tag
  alias HackNewsBackend.Repo

  schema "challenges" do
    field :description, :string
    field :title, :string
    many_to_many :tags, Tag, join_through: "challenges_tags"

    timestamps()
  end

  @doc false
  def changeset(challenge, attrs) do
    challenge
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
    |> put_assoc(:tags, parse_tags(attrs))
  end

  defp parse_tags(params) do
    (params["tags"] || [])
    |> Enum.map(& &1["name"])
    |> Enum.map(&get_or_insert_tag/1)
  end

  def all() do
    __MODULE__ |> Repo.all() |> Repo.preload(:tags)
  end

  defp get_or_insert_tag(name) do
    Repo.insert!(%Tag{name: name}, on_conflict: [set: [name: name]], conflict_target: :name)
  end
end
