defmodule DjBit.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias DjBit.Accounts.{User, Team}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :img_url, :string
    field :name, :string
    field :slack_id, :string

    belongs_to :team, Team

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :slack_id, :team_id, :img_url])
    |> validate_required([:name, :slack_id, :team_id])
    |> update_change(:slack_id, &String.upcase/1)
    |> unique_constraint(:slack_id, name: :users_slack_id_team_id_index)
  end
end
