defmodule WidgetsRUsWeb.Schema.CartTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias WidgetsRUsWeb.{Data, Resolvers}

  @desc "A cart"
  object :cart do
    field :id, :id

    field :user, :user, resolve: dataloader(Data)
  end

  object :cart_queries do
    @desc "Get all carts"
    field :carts, list_of(:cart) do
      resolve &Resolvers.Cart.list_all/3
    end

    @desc "Get a cart"
    field :cart, :cart do
      arg :id, non_null(:id)
      resolve &Resolvers.Cart.find_cart/3
    end
  end

  object :cart_mutations do
    @desc "Create a cart"
    field :create_cart, type: :cart do
      resolve &Resolvers.Cart.create_cart/3
    end

    @desc "Delete cart"
    field :delete_cart, type: :cart do
      arg :id, non_null(:id)

      resolve &Resolvers.Cart.delete_cart/3
    end
  end
end
