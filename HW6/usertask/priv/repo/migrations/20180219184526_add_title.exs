defmodule Usertask.Repo.Migrations.AddTitle do
  use Ecto.Migration

  def change do

    add :body, :text, null: false

  end
end
