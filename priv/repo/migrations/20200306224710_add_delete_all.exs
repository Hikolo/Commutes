defmodule Commutes.Repo.Migrations.AddDeleteAll do
  use Ecto.Migration
#Change on_delete for stop to delete all departures when stop is deleted
  def up do
    drop(constraint(:departures, "departures_stop_id_fkey"))
    alter table(:departures) do
      modify :stop_id, references(:stops, on_delete: :delete_all)
    end
  end

  def down do
    drop(constraint(:departures, "departures_stop_id_fkey"))
    alter table(:departures) do
      modify :stop_id, references(:stops)
    end
  end
end
