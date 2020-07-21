defmodule MelpIntellimetrica.Repo.Migrations.CreateRestaurantsTable do
  use Ecto.Migration

  def change do
    create table("restaurants") do
      add :rating, :integer
      add :name, :string
      add :site, :string
      add :email, :string
      add :phone, :string
      add :street, :string
      add :city, :string
      add :state, :string
      add :lat, :float
      add :lng, :float
      timestamps()
    end
  end
end
