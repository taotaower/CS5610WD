defmodule Usertask.Repo.Migrations.AddRelationTable do
  use Ecto.Migration

  def change do
    create table(:relations) do
      add :manager_id, references(:users, on_delete: :delete_all), null: false
      add :underling_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:relations, [:manager_id])
    create index(:relations, [:underling_id])
  end
end