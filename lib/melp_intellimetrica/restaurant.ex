defmodule MelpIntellimetrica.Restaurants.Restaurant do
  alias MelpIntellimetrica.Repo
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :string, autogenerate: false}
  schema "restaurants" do
    field(:rating, :integer)
    field(:name, :string)
    field(:email, :string)
    field(:phone, :string)
    field(:city, :string)
    field(:state, :string)
    field(:lat, :float)
    field(:lng, :float)
    timestamps()
  end

  def changeset(restaurant, params \\ %{}) do
    restaurant
    |> cast(params, [:id, :rating, :name, :email, :phone, :city, :state, :lat, :lng])
    |> validate_required([:id, :rating, :name, :email, :phone, :city, :state, :lat, :lng])
    |> validate_format(:email, ~r/@/)
    |> validate_inclusion(:rating, 0..4)
  end

  def create(%__MODULE__{} = restaurant) do
    Repo.insert(restaurant)
  end

  def delete(id) do
    rest = Repo.get_by(MelpIntellimetrica.Restaurants.Restaurant, %{id: id})
    Repo.delete(rest)
  end
end
