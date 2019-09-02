defmodule WidgetsRUs.Sales.LineItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "line_items" do
    field :quantity, :integer
    field :total, :float
    field :cart_id, :id
    field :product_id, :id

    timestamps()
  end

  @doc false
  def changeset(line_item, attrs) do
    line_item
    |> cast(attrs, [:quantity, :total])
    |> validate_required([:quantity, :total])
  end
end
