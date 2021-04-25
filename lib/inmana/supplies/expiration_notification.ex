defmodule Inmana.Supplies.ExpirationNotification do
  alias Inmana.Mailer
  alias Inmana.Supplies.{ExpirationEmail, GetByExpiration}

  def send do
    data = GetByExpiration.call()

    Task.async_stream(data, fn {to_email, supplies} ->
      send_email(to_email, supplies)
    end)
    |> Stream.run()
  end

  defp send_email(to_email, supplies) do
    to_email |> ExpirationEmail.create(supplies) |> Mailer.deliver_now!()
  end
end
