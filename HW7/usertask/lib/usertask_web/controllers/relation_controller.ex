defmodule UsertaskWeb.RelationController do
  use UsertaskWeb, :controller

  alias Usertask.Accounts
  alias Usertask.Accounts.Relation

  action_fallback UsertaskWeb.FallbackController

  def index(conn, _params) do
    relations = Accounts.list_relations()
    render(conn, "index.json", relations: relations)
  end

  def create(conn, %{"relation" => relation_params}) do
    IO.inspect "hihihihhi"
    IO.inspect relation_params

    with {:ok, %Relation{} = relation} <- Accounts.create_relation(relation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", relation_path(conn, :show, relation))
      |> render("show.json", relation: relation)
    end
  end

  def show(conn, %{"id" => id}) do
    relation = Accounts.get_relation!(id)
    render(conn, "show.json", relation: relation)
  end

  def update(conn, %{"id" => id, "relation" => relation_params}) do
    relation = Accounts.get_relation!(id)

    with {:ok, %Relation{} = relation} <- Accounts.update_relation(relation, relation_params) do
      render(conn, "show.json", relation: relation)
    end
  end

  def delete(conn, %{"id" => id}) do
    relation = Accounts.get_relation!(id)
    with {:ok, %Relation{}} <- Accounts.delete_relation(relation) do
      send_resp(conn, :no_content, "")
    end
  end
end
