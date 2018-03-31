defmodule UsertaskWeb.TaskController do
  use UsertaskWeb, :controller

  alias Usertask.Tasks
  alias Usertask.Tasks.Task

  action_fallback UsertaskWeb.FallbackController

  def index(conn, _params) do
    user_id = get_session(conn, :user_id)
   # tasks = Tasks.list_tasks()
    tasks = Tasks.list_my_tasks(user_id)
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- Tasks.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    with {:ok, %Task{} = task} <- Tasks.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    with {:ok, %Task{}} <- Tasks.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end


  defp get_users() do
    Enum.map(Usertask.Accounts.list_users, &{&1.name <> " - " <> &1.email, &1.id})
  end

  def get_user_name(user_id) do
    Usertask.Accounts.get_user(user_id).name
  end
end
