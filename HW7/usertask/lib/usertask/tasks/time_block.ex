defmodule Usertask.Tasks.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Usertask.Tasks.TimeBlock
  alias Usertask.Tasks.Task


  schema "timeblocks" do
    field :end_time, :naive_datetime
    field :start_time, :naive_datetime
   # field :task_id, :id
    belongs_to :task, Usertask.Tasks.Task


    timestamps()
  end

  @doc false
  def changeset(%TimeBlock{} = time_block, attrs) do
    time_block
    |> cast(attrs, [:start_time, :end_time])
    |> validate_required([:start_time, :end_time])
  end
end
