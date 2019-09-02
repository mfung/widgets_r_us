defmodule WidgetsRUs.Repo.Migrations.CreateLineItems do
  use Ecto.Migration

  def change do
    create table(:line_items) do
      add :quantity, :integer
      add :total, :float
      add :cart_id, references(:carts, on_delete: :nothing)
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:line_items, [:cart_id])
    create index(:line_items, [:product_id])
  end
end
