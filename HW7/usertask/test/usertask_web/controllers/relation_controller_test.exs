defmodule UsertaskWeb.RelationControllerTest do
  use UsertaskWeb.ConnCase

  alias Usertask.Accounts
  alias Usertask.Accounts.Relation

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:relation) do
    {:ok, relation} = Accounts.create_relation(@create_attrs)
    relation
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all relations", %{conn: conn} do
      conn = get conn, relation_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create relation" do
    test "renders relation when data is valid", %{conn: conn} do
      conn = post conn, relation_path(conn, :create), relation: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, relation_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, relation_path(conn, :create), relation: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update relation" do
    setup [:create_relation]

    test "renders relation when data is valid", %{conn: conn, relation: %Relation{id: id} = relation} do
      conn = put conn, relation_path(conn, :update, relation), relation: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, relation_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, relation: relation} do
      conn = put conn, relation_path(conn, :update, relation), relation: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete relation" do
    setup [:create_relation]

    test "deletes chosen relation", %{conn: conn, relation: relation} do
      conn = delete conn, relation_path(conn, :delete, relation)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, relation_path(conn, :show, relation)
      end
    end
  end

  defp create_relation(_) do
    relation = fixture(:relation)
    {:ok, relation: relation}
  end
end
