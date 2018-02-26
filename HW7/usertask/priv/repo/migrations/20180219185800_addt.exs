defmodule Usertask.Repo.Migrations.Addt do
  use Ecto.Migration

  def change do

    alter table(:tasks) do
      add :title, :text, null: false
      modify :desc, :text, null: false
    end

  end
end
