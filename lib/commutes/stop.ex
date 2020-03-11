defmodule Commutes.Stop do
  use Ecto.Schema
  alias Commutes.Departure

  schema "stops" do
    field(:stop_id, :string)
    field(:name, :string)
    timestamps()
    has_many(:departures, Departure, on_replace: :delete)
  end

  def changeset(stop, params) do
    stop
    |> Ecto.Changeset.cast(params, [])
    |> Ecto.Changeset.cast_assoc(:departures, required: true)
  end
end
