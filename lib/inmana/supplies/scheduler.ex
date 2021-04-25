defmodule Inmana.Supplies.Scheduler do
  use GenServer

  alias Inmana.Supplies.ExpirationNotification

  def start_link(_state) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state \\ %{}) do
    schedule_notification()
    {:ok, state}
  end

  @impl true
  def handle_info(_msg, state) do
    ExpirationNotification.send()
    schedule_notification()
    {:noreply, state}
  end

  # One week in miliseconds => 1000 * 60 * 60 * 24 * 7 = 604_800_000
  defp schedule_notification do
    Process.send_after(self(), :generate, 604_800_000)
  end
end
