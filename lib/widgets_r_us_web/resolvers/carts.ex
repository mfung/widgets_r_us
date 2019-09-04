defmodule WidgetsRUsWeb.Resolvers.Cart do
  alias WidgetsRUs.Sales.Cart
  alias WidgetsRUs.Repo
  alias WidgetsRUsWeb.Helpers.Errors
  import Ecto.Changeset

  def list_all(_parent, _args, %{context: %{current_user: current_user}}) do
    { :ok, WidgetsRUs.Sales.list_carts(current_user) }
  end

  def list_all(_parent, _args, _resolution) do
   {:error, "Not Authorized"}
  end

  def find_cart(_parent, %{id: id}, _resolution) do
    case WidgetsRUs.Sales.get_cart!(id) do
      nil ->
        { :error, "Cart ID #{id} not found" }
      cart ->
        { :ok, cart }
    end
  end

  def create_cart(_parent, args, %{context: %{current_user: current_user}}) do
    WidgetsRUs.Sales.create_cart(args, current_user)
  end

  def create_cart(_parent, _args, _resolution) do
    {:error, "Not Authorized"}
  end

  def delete_cart(_parent, %{id: id}, %{context: %{current_user: current_user}}) do
    cart = Repo.get(Cart, id)

    WidgetsRUs.Sales.delete_cart(cart)
  end

  def delete_cart(_parent, _args, _resolution) do
    {:error, "Not Authorized"}
  end
end
