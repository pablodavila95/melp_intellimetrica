defmodule MelpIntellimetrica.Repo do
  use Ecto.Repo,
    otp_app: :melp_intellimetrica,
    adapter: Ecto.Adapters.Postgres
end
