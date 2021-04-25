defmodule Inmana.WelcomerTest do
  use ExUnit.Case, async: true

  alias Inmana.Welcomer

  describe "welcome/1 " do
    test "When the user is special, returns a special message" do
      params = %{"name" => "BaNANa", "age" => "42"}
      expected_params = {:ok, "You are special!"}

      result = Welcomer.welcome(params)

      assert result == expected_params
    end

    test "When the user is not special, returns a message" do
      params = %{"name" => "pEdrO", "age" => "23"}
      expected_params = {:ok, "Welcome Pedro"}

      result = Welcomer.welcome(params)

      assert result == expected_params
    end

    test "When the user is under age, returns a error" do
      params = %{"name" => "ANA", "age" => "13"}
      expected_params = {:error, "You shall not pass Ana"}

      result = Welcomer.welcome(params)

      assert result == expected_params
    end
  end
end
