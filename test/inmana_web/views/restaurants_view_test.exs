defmodule InmanaWeb.RestaurantsViewTest do
  use InmanaWeb.ConnCase, async: true

  import Phoenix.View, only: [render: 3]

  alias Inmana.Restaurant
  alias InmanaWeb.RestaurantsView

  describe "render/2" do
    test "renders create.json" do
      params = %{name: "Siri Cascudo", email: "siri.cascudo@gmail.com"}

      {:ok, restaurant} = Inmana.create_restaurant(params)

      response = render(RestaurantsView, "create.json", restaurant: restaurant)

      assert %{
               message: "Restaurant created",
               restaurant: %Restaurant{
                 email: "siri.cascudo@gmail.com",
                 id: _id,
                 inserted_at: _inserted_at,
                 name: "Siri Cascudo",
                 updated_at: _updated_at
               }
             } = response
    end
  end
end
