defmodule WidgetsRUsWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation
  alias WidgetsRUsWeb.Resolvers

  @desc "A user"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
  end

  input_object :update_user_params do
    field :name, :string
    field :email, :string
  end

  object :user_queries do
    @desc "Get all users"
    field :users, list_of(:user) do
      resolve &Resolvers.User.list_all/3
    end

    @desc "Get a user"
    field :user, :user do
      arg :id, non_null(:id)
      resolve &Resolvers.User.find_user/3
    end
  end

  object :user_mutations do
    @desc "Create a user"
    field :create_user, type: :user do
      arg :name, non_null(:string)
      arg :email, non_null(:string)

      resolve &Resolvers.User.create_user/3
    end

    @desc "Update user"
    field :update_user, type: :user do
      arg :id, non_null(:id)
      arg :user, :update_user_params

      resolve &Resolvers.User.update_user/3
    end

    @desc "Delete user"
    field :delete_user, type: :user do
      arg :id, non_null(:id)

      resolve &Resolvers.User.delete_user/3
    end
  end
end