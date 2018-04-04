defmodule UsertaskWeb.TokenController do
  use UsertaskWeb, :controller
  alias Usertask.Accounts.User

  action_fallback UsertaskWeb.FallbackController

  def create(conn, %{"email" => email, "pass" => pass}) do
    with {:ok, %User{} = user} <- Usertask.Accounts.get_and_auth_user(email, pass) do
      token = Phoenix.Token.sign(conn, "auth token", user.id)
      conn
      |> put_status(:created)
      |> render("token.json", user: user, token: token)
    end
  end
end
