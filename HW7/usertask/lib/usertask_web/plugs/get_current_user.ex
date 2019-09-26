defmodule UsertaskWeb.Plugs.GetUser do
  import Plug.Conn

  def init(opts), do: opts

    def call(conn, _params) do
      # TODO: Move this function out of the router module.
      user_id = get_session(conn, :user_id)
      user = Usertask.Accounts.get_user(user_id || -1)
      assign(conn, :current_user, user)
    end
end