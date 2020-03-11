defmodule Commutes.Repo.Migrations.AddAssociation do
  use Ecto.Migration
# Change data type of line number to string
  def up do
    alter table(:departures) do
      modify :line_number, :string
      remove :expectedDateTime
    end
  end

  def down do
    alter table(:departures) do
      modify :line_number, :integer
      add :expectedDateTime, :string
    end
  end
end
