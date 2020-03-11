defmodule Commutes.Departure do
  use Ecto.Schema
  alias Commutes.Stop

  schema "departures" do
    field(:line_number, :string)
    field(:transport_mode, :string)
    field(:destination, :string)
    field(:expectedDateTime, :naive_datetime)
    timestamps()
    belongs_to(:stop, Stop)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [:line_number, :transport_mode,
				   :destination, :expectedDateTime])
  end
  
  
end
