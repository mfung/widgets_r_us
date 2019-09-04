defmodule WidgetsRUs.Sales.Cart do
  use Ecto.Schema
  import Ecto.Changeset

  alias WidgetsRUs.Accounts.User

  schema "carts" do
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(cart, attrs) do
    cart
    |> cast(attrs, [])
    |> validate_required([])
  end
end
