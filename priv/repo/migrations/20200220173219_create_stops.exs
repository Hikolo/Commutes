defmodule Commutes.Repo.Migrations.CreateStops do
  use Ecto.Migration
  # Creates tables
  
  def change do
    create table(:stops) do
      add :stop_id, :string
      add :name, :string
      timestamps()
    end
    create table(:departures) do
      add :line_number, :integer
      add :transport_mode, :string
      add :destination, :string
      add :expectedDateTime, :string
      timestamps()
    end
  end
end
