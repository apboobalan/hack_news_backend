defmodule HackNewsBackend.HackNewsBackend.Challenge do
  use Ecto.Schema
  import Ecto.Changeset

  schema "challenges" do
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(challenge, attrs) do
    challenge
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
