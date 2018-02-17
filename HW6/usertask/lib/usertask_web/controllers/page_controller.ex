defmodule UsertaskWeb.PageController do
  use UsertaskWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
