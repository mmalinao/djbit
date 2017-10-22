defmodule DjBit.Accounts.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias DjBit.Accounts.{User, Team}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "teams" do
    field :name, :string
    field :slack_id, :string

    timestamps()
  end

  @doc false
  def changeset(%Team{} = team, attrs) do
    team
    |> cast(attrs, [:name, :slack_id])
    |> validate_required([:name, :slack_id])
  end
end
