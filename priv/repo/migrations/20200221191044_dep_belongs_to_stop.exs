defmodule Commutes.Repo.Migrations.DepBelongsToStop do
  use Ecto.Migration
# Add reference to stop in departure
  def change do
    alter table(:departures) do
      add :stop_id, references(:stops)
    end

  end
end
