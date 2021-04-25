defmodule Inmana.SupplyTest do
  use Inmana.DataCase, async: true

  alias Ecto.Changeset
  alias Inmana.{Repo, Supply}

  describe "changeset/1 " do
    test "When all params are valid, returns a valid changeset" do
      params = %{
        description: "Ketchup",
        expiration_date: "2021-04-25",
        responsible: "Pedro",
        restaurant_id: "e8d44462-59b8-493e-9e92-4c3257a8f084"
      }

      result = Supply.changeset(params)

      assert %Changeset{
               changes: %{
                 description: "Ketchup",
                 expiration_date: ~D[2021-04-25],
                 responsible: "Pedro",
                 restaurant_id: "e8d44462-59b8-493e-9e92-4c3257a8f084"
               },
               valid?: true
             } = result
    end

    test "When description is missing, returns a invalid changeset" do
      params = %{
        expiration_date: "2021-04-25",
        responsible: "Pedro",
        restaurant_id: "e8d44462-59b8-493e-9e92-4c3257a8f084"
      }

      expected_result = %{description: ["can't be blank"]}

      result = Supply.changeset(params)

      assert %Changeset{valid?: false} = result
      assert errors_on(result) == expected_result
    end

    test "When expiration_date is missing, returns a invalid changeset" do
      params = %{
        description: "Ketchup",
        responsible: "Pedro",
        restaurant_id: "e8d44462-59b8-493e-9e92-4c3257a8f084"
      }

      expected_result = %{expiration_date: ["can't be blank"]}

      result = Supply.changeset(params)

      assert %Changeset{valid?: false} = result
      assert errors_on(result) == expected_result
    end

    test "When responsible is missing, returns a invalid changeset" do
      params = %{
        description: "Ketchup",
        expiration_date: "2021-04-25",
        restaurant_id: "e8d44462-59b8-493e-9e92-4c3257a8f084"
      }

      expected_result = %{responsible: ["can't be blank"]}

      result = Supply.changeset(params)

      assert %Changeset{valid?: false} = result
      assert errors_on(result) == expected_result
    end

    test "When restaurant_id is missing, returns a invalid changeset" do
      params = %{
        description: "Ketchup",
        expiration_date: "2021-04-25",
        responsible: "Pedro"
      }

      expected_result = %{restaurant_id: ["can't be blank"]}

      result = Supply.changeset(params)

      assert %Changeset{valid?: false} = result
      assert errors_on(result) == expected_result
    end

    test "When description is too short, returns a invalid changeset" do
      params = %{
        description: "Ke",
        expiration_date: "2021-04-25",
        responsible: "Pedro",
        restaurant_id: "e8d44462-59b8-493e-9e92-4c3257a8f084"
      }

      expected_result = %{description: ["should be at least 3 character(s)"]}

      result = Supply.changeset(params)

      assert %Changeset{valid?: false} = result
      assert errors_on(result) == expected_result
    end

    test "When responsible is too short, returns a invalid changeset" do
      params = %{
        description: "Ketchup",
        expiration_date: "2021-04-25",
        responsible: "Pe",
        restaurant_id: "e8d44462-59b8-493e-9e92-4c3257a8f084"
      }

      expected_result = %{responsible: ["should be at least 3 character(s)"]}

      result = Supply.changeset(params)

      assert %Changeset{valid?: false} = result
      assert errors_on(result) == expected_result
    end

    test "When restaurant_id does not exist, returns a invalid changeset" do
      params = %{
        description: "Ketchup",
        expiration_date: "2021-04-25",
        responsible: "Pedro",
        restaurant_id: "e8d44462-59b8-493e-9e92-4c3257a8f084"
      }

      expected_result = %{restaurant_id: ["does not exist"]}

      {:error, %Changeset{} = changeset} = params |> Supply.changeset() |> Repo.insert()

      assert %Changeset{valid?: false} = changeset
      assert errors_on(changeset) == expected_result
    end
  end
end
