defmodule MelpIntellimetrica do
  alias MelpIntellimetrica.Repo
  alias MelpIntellimetrica.Restaurants.Restaurant


  def get_restaurants_in_radius(latitude, longitude, radius) do
    query = [
      "SELECT * ",
      "FROM restaurants ",
      "WHERE ST_DistanceSphere(ST_SetSRID(ST_MakePoint(lat, lng),4326), ST_MakePoint(#{latitude},#{
        longitude
      })) <= #{radius}"
    ]

    case Repo.query(query, [], log: true) do
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

  #TODO handle empty queries and return an empty json/with 0s

  def get_listing_from(result) do
    {_, listing} = result
    listing
  end

  def get_list_of_ratings_from(listing) do
    Enum.map(listing, fn x -> x.rating end)
  end

  def count_restaurants_from(listing) do
    Enum.count(listing)
  end

  def sum_of_ratings_from(listing) do
    Enum.reduce(listing, 0, fn x, acc -> x.rating + acc end)
  end

  def average_rating_from(listing) when listing == [] do
    0.0
  end

  def average_rating_from(listing) do
    sum_of_ratings_from(listing) / count_restaurants_from(listing)
  end

  def std_deviation_from(listing) when listing == [] do
    0.0
  end

  def std_deviation_from(listing) do
    sum_of_substractedMean_squared =
      Enum.map(get_list_of_ratings_from(listing), fn x -> :math.pow((x - average_rating_from(listing)), 2) end) |> Enum.sum()

    sum_of_substractedMean_squared / count_restaurants_from(listing) |> :math.sqrt()
  end

  def get_ratings_data(latitude, longitude, radius) do
    listing =
      get_restaurants_in_radius(latitude, longitude, radius)
      |> get_listing_from()

    %{
      count: count_restaurants_from(listing),
      avg: average_rating_from(listing),
      std: std_deviation_from(listing)
    }
  end
end
