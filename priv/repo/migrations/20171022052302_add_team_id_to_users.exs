defmodule DjBit.Repo.Migrations.AddTeamIdToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :team_id, :binary_id
    end

    create index(:users, :team_id)
  end
end
