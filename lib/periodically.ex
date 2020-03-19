defmodule Periodically do
  use GenServer
  @moduledoc """
  #Periodically
  Runs worker at start and every 10 minutes.
  Updates departures for all stops.
  """

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    Worker.start_link()
    Worker.update_departures()
    schedule_work() # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:work, state) do
    Worker.update_departures()
    schedule_work() # Reschedule once more
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 10 * 60 * 1000) # In 10 minutes
  end
end
