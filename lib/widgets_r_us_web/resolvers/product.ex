defmodule WidgetsRUsWeb.Resolvers.Product do
  alias WidgetsRUs.Inventory.Product
  alias WidgetsRUs.Repo
  alias WidgetsRUsWeb.Helpers.Errors

  def list_all(_parent, _args, _resolution) do
    { :ok, WidgetsRUs.Inventory.list_products() }
  end

  def create_product(_parent, args, _resolution) do
    WidgetsRUs.Inventory.create_product(args)
  end

  def find_product(_parent, %{id: id}, _resolution) do
    case WidgetsRUs.Inventory.get_product!(id) do
      nil ->
        { :error, "Product ID #{id} not found" }
      product ->
        { :ok, product }
    end
  end

  def update_product(_parent, %{id: id, product: product_params}, _resolution) do
    product = Repo.get(Product, id)

    case product do
      nil ->
        { :error, "Product ID #{id} could not be updated" }
      product ->
        case WidgetsRUs.Inventory.update_product(product, product_params) do
          { :error, changeset } ->
            { :error, Errors.extract_error_messages(changeset) }
          product ->
            product
        end
    end
  end

  def delete_product(_parent, %{id: id}, _resolution) do
    product = Repo.get(Product, id)

    case product do
      nil ->
        { :error, "Product ID #{id} does not exist" }
      product ->
        WidgetsRUs.Inventory.delete_product(product)
        { :ok, %{ id: id } }
    end
  end
end
