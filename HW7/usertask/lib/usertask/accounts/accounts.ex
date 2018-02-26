defmodule Usertask.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Usertask.Repo

  alias Usertask.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end


  # We want a non-bang variant
  def get_user(id), do: Repo.get(User, id)

  # And we want by-email lookup
  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end


  alias Usertask.Accounts.Relation

  @doc """
  Returns the list of relations.

  ## Examples

      iex> list_relations()
      [%Relation{}, ...]

  """
  def list_relations do
    Repo.all(Relation)
  end

  @doc """
  Gets a single relation.

  Raises `Ecto.NoResultsError` if the Relation does not exist.

  ## Examples

      iex> get_relation!(123)
      %Relation{}

      iex> get_relation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_relation!(id), do: Repo.get!(Relation, id)

  @doc """
  Creates a relation.

  ## Examples

      iex> create_relation(%{field: value})
      {:ok, %Relation{}}

      iex> create_relation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_relation(attrs \\ %{}) do
    %Relation{}
    |> Relation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a relation.

  ## Examples

      iex> update_relation(relation, %{field: new_value})
      {:ok, %Relation{}}

      iex> update_relation(relation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_relation(%Relation{} = relation, attrs) do
    relation
    |> Relation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Relation.

  ## Examples

      iex> delete_relation(relation)
      {:ok, %Relation{}}

      iex> delete_relation(relation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_relation(%Relation{} = relation) do
    Repo.delete(relation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking relation changes.

  ## Examples

      iex> change_relation(relation)
      %Ecto.Changeset{source: %Relation{}}

  """
  def change_relation(%Relation{} = relation) do
    Relation.changeset(relation, %{})
  end

  def managers_map_for(user_id) do
    Repo.all(from r in Relation,
             where: r.underling_id == ^user_id)
    |> Enum.map(&({&1.manager_id, &1.id}))
    |> Enum.into(%{})
  end


  def underlings_map_for(user_id) do
    Repo.all(from r in Relation,
             where: r.manager_id == ^user_id)
    |> Enum.map(&({&1.underling_id, &1.id}))
    |> Enum.into(%{})
  end

  def get_relation(user_id) do
    user = Repo.get(User, user_id)
#    managers = Repo.all assoc(user, :managers)
#    managers
           |> Repo.preload(:managers)
           |> Repo.preload(:underlings)
#    IO.inspect user

  end


  def get_underlings(user_id) do
    user = Repo.get(User, user_id)
#    underlings = Repo.all assoc(user, :underlings)
#    underlings
           |> Repo.preload(:underlings)
  end
end
