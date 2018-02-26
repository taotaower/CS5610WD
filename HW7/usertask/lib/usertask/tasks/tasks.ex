defmodule Usertask.Tasks do
  @moduledoc """
  The Tasks context.
  """

  import Ecto.Query, warn: false
  alias Usertask.Repo
  alias Usertask.Tasks
  alias Usertask.Tasks.Task
  alias Usertask.Accounts
  alias Usertask.Accounts.User
  alias Usertask.Accounts.Relation

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
    |> Repo.preload(:user)
  end


  def list_my_tasks(id) do
    query = from t in Task,
                 where: t.user_id == ^id,
                 select: t
    res = Repo.all(query)
    |> Repo.preload(:user)

 #   IO.inspect res
 #   IO.inspect List.first(res)[:id]

    res

  end


  def list_underling_tasks(id) do

#    underlings = Repo.all(from r in Relation,
#             where: r.manager_id == ^id)
#       |> Enum.map(&({&1.underling_id, &1.manager_id}))
#       |> Enum.into(%{})
    user = Repo.get(User, id)
           |>Repo.preload(:underlings)

    underlings = user.underlings
                 |> Enum.map(&(&1.id))


  #  IO.inspect underlings

    tasks = List.flatten(Enum.map(underlings, fn(x) -> list_my_tasks(x) end))

  #  IO.inspect tasks

    tasks

  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id) do

    Repo.get!(Task, id)

    |> Repo.preload(:user)
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end
end
