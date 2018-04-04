defmodule UsertaskWeb.UserController do
  use UsertaskWeb, :controller

  alias Usertask.Accounts
  alias Usertask.Accounts.User

  action_fallback UsertaskWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    new_user = %{name: user_params["name"], email: user_params["email"], password_hash: Comeonin.Argon2.hashpwsalt(user_params["password"]) }
    with {:ok, %User{} = user} <- Accounts.create_user(new_user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)
    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    with {:ok, %User{}} <- Accounts.delete_user(user) do
      users = Accounts.list_users()
      render(conn, "index.json", users: users)
    end
  end
end
