defmodule UsertaskWeb.RelationView do
  use UsertaskWeb, :view
  alias UsertaskWeb.RelationView

  def render("index.json", %{relations: relations}) do
    %{data: render_many(relations, RelationView, "relation.json")}
  end

  def render("show.json", %{relation: relation}) do
    %{data: render_one(relation, RelationView, "relation.json")}
  end

  def render("relation.json", %{relation: relation}) do
    %{id: relation.id}
  end
end
