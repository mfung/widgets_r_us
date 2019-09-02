defmodule WidgetsRUs.Repo do
  use Ecto.Repo,
    otp_app: :widgets_r_us,
    adapter: Ecto.Adapters.Postgres
end
