defmodule WidgetsRUsWeb.Schema do
  use Absinthe.Schema
  import_types WidgetsRUsWeb.Schema.ProductTypes
  import_types WidgetsRUsWeb.Schema.UserTypes

  query do
    import_fields(:product_queries)
    import_fields(:user_queries)

    mutation do
      import_fields(:product_mutations)
      import_fields(:user_mutations)
    end

  end

end
