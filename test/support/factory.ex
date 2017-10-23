defmodule DjBit.Factory do
  use ExMachina.Ecto, repo: DjBit.Repo

  alias DjBit.Accounts.{User, Team}

  def slack_oauth_callback_factory do
    %{
      ok: true,
      access_token: "xoxp-#{Faker.Lorem.characters(12)}-#{Faker.Lorem.characters(12)}-#{Faker.Lorem.characters(12)}",
      scope: "identity.basic,identity.avatar,identity.team",
      user: %{ id: "U#{Faker.Lorem.characters(8) |> to_string |> String.upcase}", name: Faker.Name.name() },
      team: %{ id: "T#{Faker.Lorem.characters(8) |> to_string |> String.upcase}" }
    }
  end

  def slack_team_identity_factory do
    %{
      id: "T#{Faker.Lorem.characters(8) |> to_string |> String.upcase}",
      domain: Faker.Internet.domain_name(),
      name: Faker.Company.name(),
      image_34: Faker.Avatar.image_url(34, 34),
      image_44: Faker.Avatar.image_url(44, 44),
      image_68: Faker.Avatar.image_url(68, 68),
      image_88: Faker.Avatar.image_url(88, 88),
      image_102: Faker.Avatar.image_url(102, 102),
      image_132: Faker.Avatar.image_url(132, 132),
      image_230: Faker.Avatar.image_url(230, 230)
    }
  end

  def slack_user_identity_factory do
    %{
      ok: true,
      user: %{
        id: "U#{Faker.Lorem.characters(8) |> to_string |> String.upcase}",
        name: Faker.Name.name(),
        image_24: Faker.Avatar.image_url(24, 24),
        image_32: Faker.Avatar.image_url(32, 32),
        image_48: Faker.Avatar.image_url(48, 48),
        image_72: Faker.Avatar.image_url(72, 72),
        image_192: Faker.Avatar.image_url(192, 192),
        image_512: Faker.Avatar.image_url(512, 512)
      },
      team: build(:slack_team_identity)
    }
  end

  def user_factory do
    %User{
      name: Faker.Name.name(),
      slack_id: "U#{Faker.Lorem.characters(8) |> to_string |> String.upcase}",
      img_url: Faker.Avatar.image_url()
    }
  end

  def team_factory do
    %Team{
      name: Faker.Team.name(),
      slack_id: "T#{Faker.Lorem.characters(8) |> to_string |> String.upcase}",
      img_url: Faker.Avatar.image_url()
    }
  end
end
