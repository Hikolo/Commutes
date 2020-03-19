defmodule Worker do
  use GenServer
  alias Commutes.{Repo, Stop, Departure}
  @moduledoc """
  #Worker server
  Adds new stops and updates departures for all stops in database.
  """

  @name CW

  ## Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: CW])
  end

  # Search for stop_name and add the first result to the db
  @spec add_stop(any) :: any
  def add_stop(stop_name) do
    GenServer.call(@name, {:add_stop, stop_name})
  end
  
  # Goes through all stops in the db and fetches the upcomming departures
  # And adds them to the db
  def update_departures() do
    GenServer.cast(@name, :update_departures) 
  end
  # Removes all stops and departures from db
  def reset_database() do
    GenServer.cast(@name, :reset_database)
  end

  ## Server Callbacks
  ## These are called by the genserver in the client API
  def init(state) do
    {:ok, state}
  end

  def handle_call({:add_stop, stop_name}, _from, stats) do
    case stop_id_of(stop_name) do
      {:ok, stops} ->
        Enum.map(stops, fn(stop) -> add_stop_db(stop) end)
        {:reply, "Stops updated", stats}
      _ ->
        {:reply, :error, stats}
    end
  end

  def handle_cast(:update_departures, state) do
    Repo.delete_all("departures")
    get_stops()
    |> Enum.map(fn(stop) -> departures_of(stop) end)
    {:noreply,  state}
  end

  def handle_cast(:reset_database, state) do
    Repo.delete_all("stops")
    {:noreply, state}
  end
  
  ## Helper Functions

  defp departures_of(stop) do
    case stop.stop_id
    |> url_for_site() # Stop_id is added to the url
    |> HTTPoison.get() # Data is fetched from trafiklab api
    |> parse_departures(stop) do
      [] -> {:error, "No departures found"}
      departures -> {:ok, departures}
    end
  end

  defp parse_departures({:ok, %HTTPoison.Response{body: body, status_code: 200}},
    stop) do
    data = Poison.Parser.parse!(body, %{})["ResponseData"]
    ["Metros", "Buses", "Trains", "Trams", "Ships"]
    |> Enum.map(fn(type) -> data[type] end)
    |> List.flatten
    |> Enum.map(fn(departure) ->
      params  = %{line_number: departure["LineNumber"],
		  transport_mode: departure["TransportMode"],
		  destination: departure["Destination"],
		  expectedDateTime: departure["ExpectedDateTime"]}
		  #stop_id: stop.stop_id}

      Ecto.build_assoc(stop, :departures)
      |>Departure.changeset(params)
      |> update_departures_db
    end)
  end

  defp update_departures_db(departure) do
    Repo.insert!(departure)
  end

  defp stop_id_of(stop_name) do
    case url_for_stop(stop_name) |> HTTPoison.get() |> parse_stop do
      [] -> {:error, "No stops found"}
      stops -> {:ok, stops}
    end
  end

  defp parse_stop({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    stops = Poison.Parser.parse!(body, %{})["ResponseData"]
    for stop <- stops, do: %Stop{name: stop["Name"], stop_id: stop["SiteId"]}
  end
  
  defp add_stop_db(stop) do
    case Stop |> Repo.get_by(stop_id: stop.stop_id) do
      nil ->
        Repo.insert(stop)
      _ ->
        nil
    end
  end

  defp get_stops() do
    Repo.all(Stop)
  end

  defp url_for_stop(stop_id) do
    "https://api.sl.se/api2/typeahead.json?SearchString=#{stop_id}&StationsOnly=True&MaxResults=1&type=S&key=#{Keys.apikeystop()}"
  end

  defp url_for_site(site_id) do
    "https://api.sl.se/api2/realtimedeparturesV4.json?SiteId=#{site_id}&TimeWindows=15&key=#{Keys.apikeysite()}"
  end
  
end
