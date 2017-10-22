ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(DjBit.Repo, :manual)

Faker.start()

{:ok, _} = Application.ensure_all_started(:ex_machina)
