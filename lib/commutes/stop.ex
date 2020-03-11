defmodule Commutes.Stop do
  use Ecto.Schema
  alias Commutes.Departure

  schema "stops" do
    field(:stop_id, :string)
    field(:name, :string)
    timestamps()
    has_many(:departures, Departure)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [])
    |> Ecto.Changeset.cast_assoc(:departures, required: true)
  end
end
