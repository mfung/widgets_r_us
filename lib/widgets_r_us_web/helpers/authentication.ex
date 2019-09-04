defmodule WidgetsRUs.Helpers.Authentication do
  @moduledoc false

  import Bcrypt

  alias WidgetsRUs.Repo
  alias WidgetsRUs.Accounts.User

  def login_with_email_pass(email, given_pass) do
    user = Repo.get_by(User, email: email)

    cond do
      user && Bcrypt.verify_pass(given_pass, user.password_hash) ->
        {:ok, user}
      user ->
        {:error, "Incorrent credentials"}
      true ->
        {:error, "Authentication required"}
    end
  end
end
