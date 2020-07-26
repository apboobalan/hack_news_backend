defmodule HackNewsBackend.Auth.Authenticaton do
  use Guardian , otp_app: :hack_news_backend

  alias HackNewsBackend.{ User, Repo }

  def subject_for_token(resource, _claim), do: {:ok, to_string(resource.id)}
  def resource_from_claims(%{"sub" => id}) do
    case User |> Repo.get(id) do
      nil -> {:error, :resource_not_found}
      account -> {:ok, account}
    end
  end
end
