defmodule MelpIntellimetrica.Repo.Migrations.ChangeId do
  use Ecto.Migration
  alias MelpIntellimetrica.Repo

  import Ecto.Query, only: [from: 2]

  def up do
    alter table(:restaurants) do
      add(:new_primary_id, :string)
    end

    flush()

    alter table(:restaurants) do
      remove(:id)
      modify(:new_primary_id, :string, primary_key: true)
    end

    rename(table(:restaurants), :new_primary_id, to: :id)
  end

end
