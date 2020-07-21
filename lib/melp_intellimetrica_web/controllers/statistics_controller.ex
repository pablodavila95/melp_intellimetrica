defmodule MelpIntellimetricaWeb.StatisticsController do
  use MelpIntellimetricaWeb, :controller

  def restaurants(conn, %{"latitude" => latitude, "longitude" => longitude, "radius" => radius} = params) do
    items = MelpIntellimetrica.get_restaurants_in_radius(latitude, longitude, radius)
    render conn, "show.json", items: items
  end
end
