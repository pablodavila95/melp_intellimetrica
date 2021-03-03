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
    statistic_data = MelpIntellimetrica.calculate_rating_statistics()
    render(conn, "show.json", statistic_data: statistic_data)
  end

  def create_restaurant(conn, %{"rating" => rating, "name" => name, "email" => email, "phone" => phone, "city" => city, "state" => state, "lat" => lat, "lng" => lng}) do
    restaurant = %MelpIntellimetrica.Restaurants.Restaurant{id: Ecto.UUID.generate(), rating: String.to_integer(rating), name: name, email: email, phone: phone, city: city, state: state, lat: String.to_float(lat), lng: String.to_float(lng)}
    MelpIntellimetrica.Restaurants.Restaurant.create(restaurant)
    json(conn, %{created_at: Time.utc_now()})
  end

  def delete_restaurant(conn, %{"id" => id}) do
    MelpIntellimetrica.Restaurants.Restaurant.delete(Ecto.UUID.cast!(id))
    json(conn, %{deleted_at: Time.utc_now()})
  end
end
