defmodule UsertaskWeb.TaskController do
  use UsertaskWeb, :controller

  alias Usertask.Tasks
  alias Usertask.Tasks.Task

  action_fallback UsertaskWeb.FallbackController

  def index(conn, _params) do
   # user_id = get_session(conn, :user_id)
    tasks = Tasks.list_tasks()
   # tasks = Tasks.list_my_tasks(user_id)
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params, "token" => token}) do



    {:ok, user_id} = Phoenix.Token.verify(conn, "auth token", token, max_age: 86400)

    new_task = %{
      complete: task_params["complete"],
      desc: task_params["desc"],
      time_spent: task_params["time_spent"],
      title: task_params["title"],
      user_id: task_params["user_id"]
    }


    with {:ok, %Task{} = task} <- Tasks.create_task(new_task) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
   # IO.inspect task

   # task =  Map.put(task, :user_id, task.user.id)
   # IO.inspect task
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    IO.inspect task_params

    with {:ok, %Task{} = task} <- Tasks.update_task(task, task_params) do
      tasks = Tasks.list_tasks()
      render(conn, "index.json", tasks: tasks)
    end
  end

  def delete(conn, %{"id" => id}) do
    IO.inspect id
    task = Tasks.get_task!(id)
    with {:ok, %Task{}} <- Tasks.delete_task(task) do
      tasks = Tasks.list_tasks()
      render(conn, "index.json", tasks: tasks)
    end
  end


  defp get_users() do
    Enum.map(Usertask.Accounts.list_users, &{&1.name <> " - " <> &1.email, &1.id})
  end

  def get_user_name(user_id) do
    Usertask.Accounts.get_user(user_id).name
  end
end
