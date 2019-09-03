defmodule WidgetsRUsWeb.Resolvers.User do
  alias WidgetsRUs.Accounts.User
  alias WidgetsRUs.Repo
  alias WidgetsRUsWeb.Helpers.Errors

  def list_all(_parent, _args, _resolution) do
    { :ok, WidgetsRUs.Accounts.list_users() }
  end

  def find_user(_parent, %{id: id}, _resolution) do
    case WidgetsRUs.Accounts.get_user!(id) do
      nil ->
        { :error, "User ID #{id} not found" }
      user ->
        { :ok, user }
    end
  end

  def create_user(_parent, args, _resolution) do
    WidgetsRUs.Accounts.create_user(args)
  end

  def update_user(_parent, %{id: id, user: user_params}, _resolution) do
    user = Repo.get(User, id)

    case user do
      nil ->
        { :error, "User ID #{id} could not be updated" }
      user ->
        case WidgetsRUs.Accounts.update_user(user, user_params) do
          { :error, changeset } ->
            { :error, Errors.extract_error_messages(changeset) }
          user ->
            user
        end
    end
  end

  def delete_user(_parent, %{id: id}, _resolution) do
    user = Repo.get(User, id)

    case user do
      nil ->
        { :error, "User ID #{id} does not exist" }
      user ->
        WidgetsRUs.Accounts.delete_user(user)
        { :ok, %{ id: id } }
    end
  end
end