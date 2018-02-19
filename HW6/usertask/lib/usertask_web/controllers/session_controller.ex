defmodule UsertaskWeb.PageController do
  use UsertaskWeb, :controller
  alias Usertask.Accounts
  alias Usertask.Accounts.User


  def create(conn, %{"email" => email}) do
    user = Accounts.get_user_by_email(email)
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Welcome back #{user.name}")
      |> redirect(to: page_path(conn, :index))
    else
      conn
      |> put_flash(:error, "There is no record of this email in our system, please register.")
      |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out")
    |> redirect(to: page_path(conn, :index))
  end

  end