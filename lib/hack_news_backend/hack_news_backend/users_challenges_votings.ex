defmodule HackNewsBackend.HackNewsBackend.UsersChallengesVotings do
  use Ecto.Schema
  import Ecto.Changeset
  alias HackNewsBackend.Repo

  @primary_key false
  schema "users_challenges_votings" do
    belongs_to :user, HackNewsBackend.User
    belongs_to :challenge, HackNewsBackend.HackNewsBackend.Challenge

    timestamps()
  end

  @doc false
  def changeset(change, attrs) do
    change
    |> cast(attrs, [:challenge_id, :user_id])
    |> validate_required([:challenge_id, :user_id])
    |> unique_constraint([:challenge_id, :user_id])
  end

  def vote_challenge(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end
end
