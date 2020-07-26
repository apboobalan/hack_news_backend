defmodule HackNewsBackend.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias HackNewsBackend.Repo
@derive {Jason.Encoder, only: [:name, :email]}
  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash])
  |> put_change(:password_hash, "random")
    |> validate_required([:name, :email, :password_hash])
  end

  def create_user(params) do
    %__MODULE__{} |> changeset(params) |> Repo.insert!()
  end
end
