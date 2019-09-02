defmodule WidgetsRUsWeb.CartView do
  use WidgetsRUsWeb, :view
  alias WidgetsRUsWeb.CartView

  def render("index.json", %{carts: carts}) do
    %{data: render_many(carts, CartView, "cart.json")}
  end

  def render("show.json", %{cart: cart}) do
    %{data: render_one(cart, CartView, "cart.json")}
  end

  def render("cart.json", %{cart: cart}) do
    %{id: cart.id}
  end
end
