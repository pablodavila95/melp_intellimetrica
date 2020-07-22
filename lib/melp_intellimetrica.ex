defmodule MelpIntellimetrica do
  alias MelpIntellimetrica.{Restaurant, Repo}
  import Ecto.Query
  import Geo.PostGIS

  def get_restaurants_in_radius(latitude, longitude, radius) do
    query = [
      "SELECT *",
      "FROM restaurants",
      "WHERE ST_DistanceSphere(ST_SetSRID(ST_MakePoint(lat, lng),4326), ST_MakePoint(#{latitude},#{longitude})) <= #{radius}"
        ]
    |> Enum.join(" ")

    args = [latitude, longitude, radius]

    case Repo.query(query, args, log: true) do
      {:ok, %Postgrex.Result{columns: cols, rows: rows}} ->
        results =
          Enum.map(rows, fn row ->
            Repo.load(Restaurant, {cols, row})
          end)

        {:ok, results}

      _ ->
        {:error, :not_found}
    end
  end
end
