defmodule UsertaskWeb.TaskController do
  use UsertaskWeb, :controller

  alias Usertask.Tasks
  alias Usertask.Tasks.Task
  alias Usertask.Repo
  alias Usertask.Tasks.TimeBlock

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

    render(conn, "index.html", tasks: tasks, users: get_users())
  end

  def all_tasks(conn, _params) do
         tasks = Tasks.list_tasks()
    render(conn, "all_tasks.html", tasks: tasks,users: get_users())
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    user_id = get_session(conn, :user_id)
    render(conn, "new.html", changeset: changeset, users: get_users(user_id))
  end

  def create(conn, %{"task" => task_params}) do
    user_id = get_session(conn, :user_id)
    case Tasks.create_task(task_params) do

      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset,users: get_users(user_id))
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    blocks = Tasks.list_blocks(id)
  #  IO.inspect task
    render(conn, "show.html", task: task, user_name: get_user_name(task.user_id),blocks: blocks)
  end

  def edit(conn, %{"id" => id}) do
    user_id = get_session(conn, :user_id)
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset,users: get_users(user_id))
  end



  def update(conn, %{"id" => id, "task" => task_params}) do
    user_id = get_session(conn, :user_id)
    task = Tasks.get_task!(id)
    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset,users: get_users(user_id))
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end

  def report(conn, _params) do

    user_id = get_session(conn, :user_id)
    tasks = Tasks.list_underling_tasks(user_id)

    render(conn, "report.html", users: get_users(user_id), tasks: tasks)
    end


  def tracker(conn, %{"id" => id}) do

    task = Tasks.get_task!(id)
    blocks = Tasks.list_blocks(id)
 #changeset: changeset,
    render(conn, "tracker.html", task: task,blocks: blocks)
  end


  def new_time_block(conn, %{"id" => id}) do
    changeset = Tasks.change_time_block(%TimeBlock{})
    user_id = get_session(conn, :user_id)
    task = Tasks.get_task!(id)
    render(conn, "new_time.html", changeset: changeset, users: get_users(user_id),task: task)
  end


  def create_time_block(conn, %{"time_block" => time_block_params}) do
    user_id = get_session(conn, :user_id)
    task = Tasks.get_task!(Map.fetch!(time_block_params, "task_id"))
    IO.inspect time_block_params

    case Tasks.create_time_block(time_block_params) do
      {:ok, time_block} ->
        conn
        |> put_flash(:info, "Timestramp created successfully.")
        |> redirect(to: "#{"/tracker/"}#{task.id}")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new_time.html", changeset: changeset,users: get_users(user_id),task: task)
    end
  end


  def edit_time_block(conn, %{"id" => id}) do
    block = Tasks.get_time_block!(id)
    changeset = Tasks.change_time_block(block)
    task = Tasks.get_task!(block.task_id)

    url = "#{"/update-block/"}#{id}"

    render(conn, "edit_time.html", task: task, changeset: changeset,users: get_users(),url: url)
  end


  def update_time_block(conn, %{"id" => id, "time_block" => time_block_params}) do
    user_id = get_session(conn, :user_id)
    task = Tasks.get_task!(Map.fetch!(time_block_params, "task_id"))
    time_block = Tasks.get_time_block!(id)
    url = "#{"/update-block/"}#{id}"
    case Tasks.update_time_block(time_block, time_block_params) do
      {:ok, time_block} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: "#{"/tracker/"}#{task.id}")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit_time.html", task: task, changeset: changeset,users: get_users(user_id),url: url)
    end
  end


#  def create_block(conn, %{"task" => task_params}) do
#    user_id = get_session(conn, :user_id)
#    case Tasks.create_task(task_params) do
#
#      {:ok, task} ->
#        conn
#        |> put_flash(:info, "Task created successfully.")
#        |> redirect(to: task_path(conn, :show, task))
#      {:error, %Ecto.Changeset{} = changeset} ->
#        render(conn, "new.html", changeset: changeset,users: get_users(user_id))
#    end
#  end

  defp get_users(user_id) do
    Enum.map(Usertask.Accounts.get_relation(user_id).underlings, &{&1.name <> " - " <> &1.email, &1.id})
  end

  defp get_users() do
    Enum.map(Usertask.Accounts.list_users, &{&1.name <> " - " <> &1.email, &1.id})
  end
  def get_user_name(user_id) do
    Usertask.Accounts.get_user(user_id).name
  end
end
