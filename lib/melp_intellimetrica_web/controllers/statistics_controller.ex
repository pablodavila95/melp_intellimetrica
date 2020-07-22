defmodule MelpIntellimetricaWeb.StatisticsController do
  use MelpIntellimetricaWeb, :controller

  def ratings_in_area(conn, %{"latitude" => latitude, "longitude" => longitude, "radius" => radius}) do
    statistic_data = MelpIntellimetrica.get_ratings_data(latitude, longitude, radius)
    render conn, "show.json", statistic_data: statistic_data
  end
end
