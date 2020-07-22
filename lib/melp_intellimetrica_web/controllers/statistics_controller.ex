defmodule MelpIntellimetricaWeb.StatisticsController do
  use MelpIntellimetricaWeb, :controller

  def restaurants(conn, %{"latitude" => latitude, "longitude" => longitude, "radius" => radius} = params) do
    statistic_data = MelpIntellimetrica.get_statistical_data(latitude, longitude, radius)
    render conn, "show.json", statistic_data: statistic_data
  end
end
