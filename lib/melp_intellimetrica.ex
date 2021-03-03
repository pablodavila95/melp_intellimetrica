defmodule MelpIntellimetrica do
  alias MelpIntellimetrica.Repo
  alias MelpIntellimetrica.Restaurants.Restaurant


  defp get_restaurants_in_radius(latitude, longitude, radius) do
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

  defp get_listing_from(result) do
    {_, listing} = result
    listing
  end

  defp get_list_of_ratings_from(listing) do
    Enum.map(listing, fn x -> x.rating end)
  end

  defp count_restaurants_from(listing) do
    Enum.count(listing)
  end

  defp sum_of_ratings_from(listing) do
    Enum.reduce(listing, 0, fn x, acc -> x.rating + acc end)
  end

  defp average_rating_from(listing) when listing == [] do
    0.0
  end

  defp average_rating_from(listing) do
    sum_of_ratings_from(listing) / count_restaurants_from(listing)
  end

  defp std_deviation_from(listing) when listing == [] do
    0.0
  end

  defp std_deviation_from(listing) do
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

  def get_restaurants_by(:state, query) do
    result =
      Repo.all(Restaurant)
      |> Enum.filter(fn x -> x.state == query end)
      |> Enum.map(fn x -> x.name end)

      %{
        restaurants: result
      }
  end

  def get_restaurants_by(:city, query) do
    result =
      Repo.all(Restaurant)
      |> Enum.filter(fn x -> x.city == query end)
      |> Enum.map(fn x -> x.name end)

      %{
        restaurants: result
      }
  end

  def get_restaurants_by(:rating, query) do
    result =
      Repo.all(Restaurant)
      |> Enum.filter(fn x -> x.rating == String.to_integer(query) end)
      |> Enum.map(fn x -> x.name end)

      %{
        restaurants: result
      }
  end

  defp calculate_rating(rating, count) do
    result =
      Repo.all(Restaurant)
      |> Enum.filter(fn x -> x.rating == rating end)
      |> Enum.map(fn x -> x.rating end)
    total_sum = Enum.sum(result)
    (total_sum / count) * 100
  end

  def calculate_rating_statistics do
    count = count_restaurants_from(Repo.all(Restaurant))

    #In the future, a GenServer could be implemented to calculate the ratings in parallel.
    rating_0 = calculate_rating(0, count)
    rating_1 = calculate_rating(1, count)
    rating_2 = calculate_rating(2, count)
    rating_3 = calculate_rating(3, count)
    rating_4 = calculate_rating(4, count)
    rating_5 = calculate_rating(5, count)

    %{
      zero: "#{rating_0}%",
      one: "#{rating_1}%",
      two: "#{rating_2}%",
      three: "#{rating_3}%",
      four: "#{rating_4}%",
      five: "#{rating_5}%"
    }
  end


end
