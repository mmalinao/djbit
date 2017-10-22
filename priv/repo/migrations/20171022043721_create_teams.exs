defmodule DjBit.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :slack_id, :string

      timestamps()
    end

    create index(:teams, :slack_id)
  end
end
