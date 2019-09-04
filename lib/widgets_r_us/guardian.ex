defmodule WidgetsRUs.Guardian do
  use Guardian, otp_app: :widgets_r_us

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def subject_for_token(_, _) do
    {:error, "Not authorized"}
  end

  def resource_from_claims(claims) do
    {:ok, User.find(claims["sub"])}
  end

  def resource_from_claims(_claims) do
    {:error, "Not authorized"}
  end
end
