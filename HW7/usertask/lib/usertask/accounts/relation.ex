defmodule Usertask.Accounts.Relation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Usertask.Accounts.Relation
  alias Usertask.Accounts.User

  schema "relations" do
    belongs_to :manager, User
    belongs_to :underling, User

    timestamps()
  end

  @doc false
  def changeset(%Relation{} = relation, attrs) do
    relation
    |> cast(attrs, [:manager_id,:underling_id])
    |> validate_required([:manager_id,:underling_id])
  end
end
