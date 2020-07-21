defmodule MelpIntellimetrica.Repo.Migrations.UploadData do
  use Ecto.Migration
  alias MelpIntellimetrica.Restaurants.Restaurant

  def store_it(row) do
    changeset = Restaurant.changeset(%Restaurant{}, row)
    MelpIntellimetrica.Repo.insert!(changeset)
  end


  def up do
    "#{__DIR__}/./restaurantes.csv"
    |> File.stream!()
    |> Stream.drop(1)
    |> CSV.decode(headers: [:id, :rating, :name, :site, :email, :phone, :street, :city, :state, :lat, :lng])
    |> Enum.each(&MelpIntellimetrica.Repo.Migrations.UploadData.store_it/1)
  end

  def down do

  end
end
