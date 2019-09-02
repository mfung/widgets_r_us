defmodule WidgetsRUsWeb.Schema.ProductTypes do
  use Absinthe.Schema.Notation
  alias WidgetsRUsWeb.Resolvers

  @desc "A product"
  object :product do
    field :id, :id
    field :name, :string
    field :description, :string
    field :price, :float
  end

  input_object :update_product_params do
    field :name, :string
    field :description, :string
    field :price, :float
  end

  object :post_queries do
    @desc "Get all products"
    field :products, list_of(:product) do
      resolve &Resolvers.Product.list_all/3
    end

    @desc "Get a product"
    field :product, :product do
      arg :id, non_null(:id)
      resolve &Resolvers.Product.find_product/3
    end
  end

  object :post_mutations do
    @desc "Create product"
    field :create_product, type: :product do
      arg :name, non_null(:string)
      arg :description, :string
      arg :price, non_null(:float)

      resolve &Resolvers.Product.create_product/3
    end

    @desc "Update product"
    field :update_product, type: :product do
      arg :id, non_null(:id)
      arg :product, :update_product_params

      resolve &Resolvers.Product.update_product/3
    end

    @desc "Delete product"
    field :delete_product, type: :product do
      arg :id, non_null(:id)

      resolve &Resolvers.Product.delete_product/3
    end
  end
end
