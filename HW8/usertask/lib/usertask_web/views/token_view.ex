defmodule UsertaskWeb.TokenView do
  use UsertaskWeb, :view

  def render("token.json", %{user: user, token: token}) do
    %{
      user_id: user.id,
      token: token,
    }
  end
end
