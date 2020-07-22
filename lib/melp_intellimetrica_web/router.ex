defmodule MelpIntellimetricaWeb.Router do
  use MelpIntellimetricaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/restaurants", MelpIntellimetricaWeb do
    pipe_through :api
    get "/statistics", StatisticsController, :ratings_in_area
    get "/byState", StatisticsController, :statistics_by_state #TODO program controller
    get "/byCity", StatisticsController, :statistics_by_city #TODO program controller
    #TODO show count with rating x
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: MelpIntellimetricaWeb.Telemetry
    end
  end
end
