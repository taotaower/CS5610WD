defmodule Usertask.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Usertask.Tasks.Task
  alias Usertask.Accounts.User
  alias Usertask.Repo


  schema "tasks" do
    field :complete, :boolean, default: false
    field :desc, :string
    field :title, :string
    field :time_spent, :integer
   # field :user_id, :id
    belongs_to :user, Usertask.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title,:desc, :time_spent, :complete,:user_id])
    |> validate_required([:desc,:title, :time_spent, :complete])
  end

  def get_task!(id) do

    Repo.get!(Task, id)

    |> Repo.preload(:user)
  end

  def get_my_tasks!(id) do

    Repo.get_by(Task, user_id: id)

  end

end
