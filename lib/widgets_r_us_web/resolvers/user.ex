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
end