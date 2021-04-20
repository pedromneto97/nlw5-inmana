defmodule Inmana.Welcomer do
  # Recebe um nome e idade
  # Se o usuário chamar "banana" e a idade for 42,  recebe mensagem especial
  # Se o usuário for maior de idade, recebe mensagem normal
  # se o usuário for menor de idade, retorna um erro
  # Tratar o nome do usuario
  def welcome(%{"name" => name, "age" => age}) do
    age = age |> String.to_integer()
    name |> String.trim() |> String.downcase() |> Macro.camelize() |> evaluate(age)
  end

  defp evaluate("Banana", 42) do
    {:ok, "Você é especial!"}
  end

  defp evaluate(name, age) when age >= 18 do
    {:ok, "Bem vindo #{name}"}
  end

  defp evaluate(name, _age) do
    {:error, "You shall not pass #{name}"}
  end
end
