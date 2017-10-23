defmodule DjBit.Accounts.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias DjBit.Accounts.{User, Team}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "teams" do
    field :name, :string
    field :slack_id, :string
    field :img_url, :string

    has_many :users, User

    timestamps()
  end

  @doc false
  def changeset(%Team{} = team, attrs) do
    team
    |> cast(attrs, [:name, :slack_id, :img_url])
    |> validate_required([:name, :slack_id])
    |> update_change(:slack_id, &String.upcase/1)
    |> unique_constraint(:slack_id, name: :teams_slack_id_index)
  end
end
