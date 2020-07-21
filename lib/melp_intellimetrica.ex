defmodule MelpIntellimetrica do
  alias MelpIntellimetrica.{Restaurant, Repo}
  import Ecto.Query
  import Geo.PostGIS

  def get_restaurants_in_radius(latitude, longitude, radius) do
    query = [
      "SELECT * FROM restaurants JOIN target ON true",
      "WHERE ST_DWithin(geom::geography, ST_SetSRID(ST_MakePoint(#{latitude},#{longitude}),4326)::geography, #{radius});"
    ]

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
