defmodule DjBit.Factory do
  use ExMachina.Ecto, repo: DjBit.Repo

  alias DjBit.Accounts.User

  def slack_token_exchange_factory do
    %{
      ok: true,
      access_token: "xoxp-#{Faker.Lorem.characters(12)}-#{Faker.Lorem.characters(12)}-#{Faker.Lorem.characters(12)}",
      scope: "identity.basic,identity.avatar,identity.team",
      user: %{ id: "U#{Faker.Lorem.characters(8) |> to_string |> String.upcase}", name: Faker.Name.name() },
      team: %{ id: "T#{Faker.Lorem.characters(8) |> to_string |> String.upcase}" }
    }
  end

  def user_factory do
    %User{
      name: Faker.Name.name(),
      slack_id: "U#{Faker.Lorem.characters(8) |> to_string |> String.upcase}",
      img_url: Faker.Avatar.image_url()
    }
  end
end
