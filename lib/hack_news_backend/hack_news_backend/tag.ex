defmodule HackNewsBackend.HackNewsBackend.Tag do
  use Ecto.Schema

  alias HackNewsBackend.HackNewsBackend.Challenge

  schema "tags" do
    field :name, :string
    many_to_many :challenges, Challenge, join_through: "challenges_tags"

    timestamps()
  end
end
