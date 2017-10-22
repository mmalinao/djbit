defmodule DjBit.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias DjBit.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :img_url, :string
    field :name, :string
    field :slack_id, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :slack_id, :img_url])
    |> validate_required([:name, :slack_id])
  end
end
