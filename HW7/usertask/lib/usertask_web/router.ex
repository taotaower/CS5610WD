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
    get "/report", TaskController, :report
    get "/tracker/:id", TaskController, :tracker
    get "/block/:id", TaskController, :new_time_block
    get "/edit_block/:id", TaskController, :edit_time_block
    get "/profile", UserController, :profile
    resources "/users", UserController
    resources "/tasks", TaskController
    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
    post "/create-block", TaskController, :create_time_block
    put "/update-block/:id", TaskController, :update_time_block
  end

  scope "/api/v1", UsertaskWeb do
    pipe_through :api
    resources "/relations", RelationController, except: [:new, :edit]
    resources "/timeblocks", TimeBlockController, except: [:new, :edit]

  end

  # Other scopes may use custom stacks.
  # scope "/api", UsertaskWeb do
  #   pipe_through :api
  # end
end
