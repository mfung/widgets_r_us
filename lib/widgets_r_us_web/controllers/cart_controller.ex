defmodule WidgetsRUsWeb.CartController do
  use WidgetsRUsWeb, :controller

  alias WidgetsRUs.Sales
  alias WidgetsRUs.Sales.Cart

  action_fallback WidgetsRUsWeb.FallbackController

  def index(conn, _params) do
    carts = Sales.list_carts()
    render(conn, "index.json", carts: carts)
  end

  def create(conn, %{"cart" => cart_params}) do
    with {:ok, %Cart{} = cart} <- Sales.create_cart(cart_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.cart_path(conn, :show, cart))
      |> render("show.json", cart: cart)
    end
  end

  def show(conn, %{"id" => id}) do
    cart = Sales.get_cart!(id)
    render(conn, "show.json", cart: cart)
  end

  def update(conn, %{"id" => id, "cart" => cart_params}) do
    cart = Sales.get_cart!(id)

    with {:ok, %Cart{} = cart} <- Sales.update_cart(cart, cart_params) do
      render(conn, "show.json", cart: cart)
    end
  end

  def delete(conn, %{"id" => id}) do
    cart = Sales.get_cart!(id)

    with {:ok, %Cart{}} <- Sales.delete_cart(cart) do
      send_resp(conn, :no_content, "")
    end
  end
end
