defmodule Commutes.Repo do
  use Ecto.Repo,
    otp_app: :commutes,
    adapter: Ecto.Adapters.Postgres
end
