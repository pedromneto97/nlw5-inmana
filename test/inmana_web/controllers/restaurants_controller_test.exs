defmodule InmanaWeb.RestaurantsControllerTest do
  use InmanaWeb.ConnCase

  describe "create/2" do
    test "when all params are valid, creates the restaurant", %{conn: conn} do
      params = %{name: "Siri Cascudo", email: "siri.cascudo@gmail.com"}

      response =
        conn |> post(Routes.restaurants_path(conn, :create, params)) |> json_response(:created)

      assert %{
               "message" => "Restaurant created",
               "restaurant" => %{
                 "email" => "siri.cascudo@gmail.com",
                 "name" => "Siri Cascudo",
                 "id" => _id
               }
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{}

      expected_response = %{
        "message" => "One or more params are invalid",
        "errors" => %{
          "email" => ["can't be blank"],
          "name" => ["can't be blank"]
        }
      }

      response =
        conn
        |> post(Routes.restaurants_path(conn, :create, params))
        |> json_response(:bad_request)

      assert expected_response == response
    end
  end
end
