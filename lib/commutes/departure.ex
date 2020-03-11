defmodule Commutes.Departure do
  use Ecto.Schema
  import Ecto.Changeset
  alias Commutes.Stop

  schema "departures" do
    field(:line_number, :string)
    field(:transport_mode, :string)
    field(:destination, :string)
    field(:expectedDateTime, :naive_datetime)
    timestamps()
    belongs_to(:stop, Stop)
  end

  def changeset(departure, params) do
    departure
    |> cast(params, [:line_number, :transport_mode,
		    :destination, :expectedDateTime,
		    :stop_id])
    #|> put_assoc(:stop, params.stop)
  end
  
  
end
