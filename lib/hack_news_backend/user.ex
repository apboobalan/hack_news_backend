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
    |> cast(attrs, [:name, :email, :password])
    |> validate_fields()
    |> generate_password_hash
  end

  def validate_fields(changeset) do
    changeset
    |> validate_required([:name, :email, :password])
    |> validate_length(:email, min: 5, max: 255)
    |> validate_format(:email, ~r/@/)
  end

  def generate_password_hash(%{valid?: true, changes: %{password: password}} = changeset) do
    changeset |> put_change(:password_hash, Bcrypt.hash_pwd_salt(password))
  end

  def generate_password_hash(changeset), do: changeset

  def create_user(params) do
    %__MODULE__{} |> changeset(params) |> Repo.insert!()
  end
end
