defmodule Inmana.Supplies.ExpirationEmail do
  import Bamboo.Email

  alias Inmana.Supply

  def create(email, supplies) do
    new_email(
      to: email,
      from: "app@inmana.com.br",
      subject: "Supplies that are about to expire",
      text_body: email_text(supplies)
    )
  end

  defp email_text(supplies),
    do:
      Enum.reduce(
        supplies,
        "---------- Supplies that are about to expire ----------\n",
        fn supply, text -> text <> supply_string(supply) end
      )

  defp supply_string(%Supply{
         description: description,
         expiration_date: expiration_date,
         responsible: responsible
       }),
       do:
         "Description: #{description}, Expiration Date: #{expiration_date}, Responsible: #{
           responsible
         }\n"
end
