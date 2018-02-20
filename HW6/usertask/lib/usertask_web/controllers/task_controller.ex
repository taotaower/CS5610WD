defmodule UsertaskWeb.TaskController do
  use UsertaskWeb, :controller

  alias Usertask.Tasks
  alias Usertask.Tasks.Task
  alias Usertask.Repo

  def index(conn, _params) do
#    IO.inspect get_session(conn, :user_id)
    user_id = get_session(conn, :user_id)
#    tasks = Repo.get_by(Task, user_id: user_id)
#    IO.inspect tasks
    #tasks = Task.get_task!(id)

    tasks = Tasks.list_my_tasks(user_id)
    #tasks = Tasks.list_tasks()

  #  IO.inspect Tasks.list_tasks()
    IO.inspect tasks

    render(conn, "index.html", tasks: tasks,users: get_users())
  end

  def all_tasks(conn, _params) do
         tasks = Tasks.list_tasks()
    render(conn, "all_tasks.html", tasks: tasks,users: get_users())
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    render(conn, "new.html", changeset: changeset, users: get_users())
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset,users: get_users())
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
  #  IO.inspect task
    render(conn, "show.html", task: task, user_name: get_user_name(task.user_id))
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset,users: get_users())
  end

  def edit_time(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    render(conn, "edit_time.html", task: task, changeset: changeset,users: get_users())
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)
    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset,users: get_users())
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end

  defp get_users() do
    Enum.map(Usertask.Accounts.list_users, &{&1.name, &1.id})
  end

  def get_user_name(user_id) do
    Usertask.Accounts.get_user(user_id).name
  end
end
