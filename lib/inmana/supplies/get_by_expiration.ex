defmodule Inmana.Supplies.GetByExpiration do
  alias Inmana.{Repo, Supply, Restaurant}
  import Ecto.Query

  def call do
    today = Date.utc_today()
    end_of_week = Date.end_of_week(today)
    beggining_of_week = Date.beginning_of_week(today)

    query =
      from supply in Supply,
        where:
          supply.expiration_date >= ^beggining_of_week and supply.expiration_date <= ^end_of_week,
        preload: [:restaurant]

    query
    |> Repo.all()
    |> Enum.group_by(fn %Supply{restaurant: %Restaurant{email: email}} -> email end)
  end
end