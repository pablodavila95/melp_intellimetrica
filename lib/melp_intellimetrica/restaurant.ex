defmodule MelpIntellimetrica.Restaurant do
  use Ecto.Schema
  @primary_key {:id, :string, autogenerate: false}
  import Ecto.Changeset

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
    |> cast(params, [:rating, :name, :email, :phone, :city, :state, :lat, :lng])
    |> validate_required([:rating, :name, :email, :phone, :city, :state, :lat, :lng])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:rating, is: 1)
    |> validate_inclusion(:rating, 0..4)
  end
end
