defmodule UsertaskWeb.Router do
  use UsertaskWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug UsertaskWeb.Plugs.GetUser
  end

#  def get_current_user(conn, _params) do
#    # TODO: Move this function out of the router module.
#    user_id = get_session(conn, :user_id)
#    user = Usertask.Accounts.get_user(user_id || -1)
#    assign(conn, :current_user, user)
#  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UsertaskWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/all_tasks", TaskController, :all_tasks
    get "/task/edit_time", TaskController, :edit_time
    resources "/users", UserController
    resources "/tasks", TaskController
    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
  end



  # Other scopes may use custom stacks.
  # scope "/api", UsertaskWeb do
  #   pipe_through :api
  # end


  # Other scopes may use custom stacks.
  scope "/api/v1", UsertaskWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    resources "/tasks", TaskController, except: [:new, :edit]
    post "/token", TokenController, :create
  end
end
