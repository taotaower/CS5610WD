defmodule Usertask.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Usertask.Accounts.User
  alias Usertask.Accounts.Relation


  schema "users" do
    field :email, :string
    field :name, :string
    has_many :manager_relations, Relation, foreign_key: :manager_id
    has_many :underling_relations, Relation, foreign_key: :underling_id
    has_many :managers, through: [:underling_relations, :manager]
    has_many :underlings, through: [:manager_relations, :underling]

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
    |> validate_format(:email, ~r/.*?@.*?.com/)
    |> unique_constraint(:email)
  end
end
