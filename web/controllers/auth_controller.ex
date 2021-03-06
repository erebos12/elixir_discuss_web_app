defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug Ueberauth

  alias Discuss.User

  def callback(%{assigns: %{ ueberauth_auth: auth}} = conn, params) do
    IO.inspect(auth)
    user_params = %{ token: auth.credentials.token, email: auth.info.email, provider: "github" }
    changeset = User.changeset(%User{}, user_params)
    insert_or_update_user(changeset)
  end

  defp insert_or_update_user(changeset) do
     case Repo.get_by(User, email: changeset.changes.email) do
      nil -> Repo.insert(changeset) # user is not yet existing,s o insert it
      user -> {:ok, user}
     end
  end

end
