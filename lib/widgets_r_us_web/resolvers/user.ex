defmodule WidgetsRUsWeb.Resolvers.User do
  alias WidgetsRUs.Accounts.User
  alias WidgetsRUs.Repo
  alias WidgetsRUsWeb.Helpers.Errors
  alias WidgetsRUs.Helpers.Authentication

  def login(%{email: email, password: password}, _info) do
    with {:ok, user} <- Authentication.login_with_email_pass(email, password),
         {:ok, jwt, _} <- WidgetsRUs.Guardian.encode_and_sign(user),
         {:ok, _} <- WidgetsRUs.Accounts.store_token(user, jwt) do
           {:ok, %{token: jwt}}
         end
  end

  def list_all(_parent, _args, %{context: %{current_user: _current_user}}) do
    { :ok, WidgetsRUs.Accounts.list_users() }
  end

  def list_all(_parent, _args, _resolution) do
   {:error, "Not Authorized"}
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
