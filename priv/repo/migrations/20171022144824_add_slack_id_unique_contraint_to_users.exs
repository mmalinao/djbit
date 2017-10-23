defmodule DjBit.Repo.Migrations.AddSlackIdUniqueContraintToUsers do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:slack_id, :team_id])
  end
end
