defmodule DjBit.Repo.Migrations.AddSlackIdUniqueContraintToTeams do
  use Ecto.Migration

  def change do
    drop index(:teams, [:slack_id])
    create unique_index(:teams, [:slack_id])
  end
end
