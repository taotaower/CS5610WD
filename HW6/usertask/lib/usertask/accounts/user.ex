defmodule Usertask.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Usertask.Accounts.User


  schema "users" do
    field :email, :string
    field :name, :string

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
