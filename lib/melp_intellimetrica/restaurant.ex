defmodule MelpIntellimetrica.Restaurants.Restaurant do
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
end
