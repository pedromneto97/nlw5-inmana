defmodule Inmana.RestaurantTest do
  use Inmana.DataCase

  alias Ecto.Changeset
  alias Inmana.{Restaurant, Repo}

  describe "changeset/1 " do
    test "When all params are valid, returns a valid changeset" do
      params = %{name: "Siri Cascudo", email: "siri.cascudo@gmail.com"}

      result = Restaurant.changeset(params)

      assert %Changeset{
               changes: %{
                 email: "siri.cascudo@gmail.com",
                 name: "Siri Cascudo"
               },
               valid?: true
             } = result
    end

    test "When e-mail is missing, returns a invalid changeset" do
      params = %{name: "Siri Cascudo"}
      expected_result = %{email: ["can't be blank"]}

      result = Restaurant.changeset(params)

      assert %Changeset{valid?: false} = result
      assert errors_on(result) == expected_result
    end

    test "When name is missing, returns a invalid changeset" do
      params = %{email: "siri.cascudo@gmail.com"}
      expected_result = %{name: ["can't be blank"]}

      result = Restaurant.changeset(params)

      assert %Changeset{valid?: false} = result
      assert errors_on(result) == expected_result
    end

    test "When name is too short, returns a invalid changeset" do
      params = %{email: "siri.cascudo@gmail.com", name: "S"}
      expected_result = %{name: ["should be at least 2 character(s)"]}

      result = Restaurant.changeset(params)

      assert %Changeset{valid?: false} = result
      assert errors_on(result) == expected_result
    end

    test "When e-mail is invalid, returns a invalid changeset" do
      params = %{email: "siri.cascudo", name: "Siri Cascudo"}
      expected_result = %{email: ["has invalid format"]}

      result = Restaurant.changeset(params)

      assert %Changeset{valid?: false} = result
      assert errors_on(result) == expected_result
    end

    test "When e-mail is not unique, returns a invalid changeset" do
      params = %{name: "Siri Cascudo", email: "siri.cascudo@gmail.com"}
      expected_result = %{email: ["has already been taken"]}

      params |> Restaurant.changeset() |> Repo.insert!()

      {:error, %Changeset{} = changeset} = params |> Restaurant.changeset() |> Repo.insert()

      assert %Changeset{valid?: false} = changeset
      assert errors_on(changeset) == expected_result
    end
  end
end
