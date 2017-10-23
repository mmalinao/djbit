defmodule DjBit.Repo.Migrations.AddImgUrlToTeams do
  use Ecto.Migration

  def change do
    alter table("teams") do
      add :img_url, :string
    end
  end
end
