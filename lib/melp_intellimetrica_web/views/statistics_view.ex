defmodule MelpIntellimetricaWeb.StatisticsView do
  use MelpIntellimetricaWeb, :view

  def render("show.json", %{statistic_data: statistic_data}) do
    statistic_data
  end
end
