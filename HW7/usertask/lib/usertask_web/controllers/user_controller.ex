defmodule UsertaskWeb.UserController do
  use UsertaskWeb, :controller

  alias Usertask.Accounts
  alias Usertask.Accounts.User
  alias Usertask.Accounts.Relation

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]
    users = Accounts.list_users()
    managers = Accounts.managers_map_for(current_user.id)
    render(conn, "index.html", users: users, managers: managers)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset, users: Enum.map(Accounts.list_users, &{&1.name <> " - " <> &1.email, &1.id}))
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end

  def profile(conn, _params) do
    current_user = conn.assigns[:current_user]
    relation = Accounts.get_relation(current_user.id)
 #   underlings = Accounts.get_underlings(current_user.id)
    managers = relation.managers
    underlings = relation.underlings
    render(conn, "profile.html", managers: managers, underlings: underlings)
  end

end

#def get_users() do
#  Enum.map(Usertask.Accounts.list_users, &{&1.name <> " - " <> &1.email, &1.id})
#end