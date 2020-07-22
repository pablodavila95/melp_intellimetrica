defmodule MelpIntellimetricaWeb.StatisticsController do
  use MelpIntellimetricaWeb, :controller

  def ratings_in_area(conn, %{
        "latitude" => latitude,
        "longitude" => longitude,
        "radius" => radius
      }) do
    statistic_data = MelpIntellimetrica.get_ratings_data(latitude, longitude, radius)
    render(conn, "show.json", statistic_data: statistic_data)
  end

  def statistics_by_state(conn, %{"state" => state}) do
    statistic_data = MelpIntellimetrica.get_restaurants_by(:state, state)
    render(conn, "index.json", statistic_data: statistic_data)
  end

  def statistics_by_city(conn, %{"city" => city}) do
    statistic_data = MelpIntellimetrica.get_restaurants_by(:city, city)
    render(conn, "index.json", statistic_data: statistic_data)
  end

  def statistics_by_rating(conn, %{"rating" => rating}) do
    statistic_data = MelpIntellimetrica.get_restaurants_by(:rating, rating)
    render(conn, "index.json", statistic_data: statistic_data)
  end

  def rating_statistics(conn, _) do
    rating_data = ""
    render(conn, "show.json", statistic_data: rating_data)
  end
end
