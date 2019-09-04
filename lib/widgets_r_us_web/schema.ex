defmodule WidgetsRUsWeb.Schema do
  use Absinthe.Schema

  import_types WidgetsRUsWeb.Schema.ProductTypes
  import_types WidgetsRUsWeb.Schema.UserTypes
  import_types WidgetsRUsWeb.Schema.CartTypes

  alias WidgetsRUsWeb.Data

  query do
    import_fields(:product_queries)
    import_fields(:user_queries)
    import_fields(:cart_queries)

    mutation do
      import_fields(:product_mutations)
      import_fields(:user_mutations)
      import_fields(:cart_mutations)
    end

  end

  def context(ctx) do
    loader = Dataloader.new()
    |> Dataloader.add_source(Data, Data.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
