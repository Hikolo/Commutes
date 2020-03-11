defmodule Commutes.Repo.Migrations.AddExpectedtime do
  use Ecto.Migration
# Change type for expectedDateTime to datetime
  def up do
    alter table(:departures) do
      add :expectedDateTime, :naive_datetime
    end
  end
  def down do
    alter table(:departures) do
      remove :expectedDateTime
    end
  end
end
