defmodule Inmana do
  @moduledoc """
  Inmana keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Inmana.Restaurants.Create, as: CreateRestaurant
  alias Inmana.Supplies.Create, as: CreateSupply
  alias Inmana.Supplies.Get, as: GetSupply

  defdelegate create_restaurant(params), to: CreateRestaurant, as: :call

  defdelegate create_supply(params), to: CreateSupply, as: :call
  defdelegate get_supply(params), to: GetSupply, as: :call
end
