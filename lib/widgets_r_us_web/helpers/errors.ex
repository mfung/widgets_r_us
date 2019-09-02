defmodule WidgetsRUsWeb.Helpers.Errors do
  def extract_error_messages(changeset) do
    changeset.errors
    |> Enum.map(fn {item, {error, _details}} -> [field: item, message: String.capitalize(error)] end)
  end
end
