defmodule Usertask.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Usertask.Tasks.Task


  schema "tasks" do
    field :complete, :boolean, default: false
    field :desc, :string
    field :time_spent, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:desc, :time_spent, :complete])
    |> validate_required([:desc, :time_spent, :complete])
  end
end
