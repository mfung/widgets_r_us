defmodule WidgetsRUsWeb.Schema do
  use Absinthe.Schema
  import_types WidgetsRUsWeb.Schema.ProductTypes

  query do
    import_fields(:post_queries)

    mutation do
      import_fields(:post_mutations)
    end

  end

end
