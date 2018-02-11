defmodule MemoryWeb.GamesChannel do
  use MemoryWeb, :channel

  alias Memory.Game

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      game = Memory.GameBackup.load(name) || Game.initialGrids()
     # game = Game.initialGrids()
      socket = socket
               |> assign(:game, game)
               |> assign(:name, name)
      {:ok, %{"join" => name,"game" => game}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("restart", %{}, socket) do
      game = Game.initialGrids()
      Memory.GameBackup.save(socket.assigns[:name], game)
      socket = socket
               |> assign(:game, game)
      {:reply, {:ok, %{ "game" => game}}, socket}

      end

  def handle_in("flipLock", %{"id" => id}, socket) do

      state = socket.assigns[:game]
#      IO.inspect {:sssstate, state}
      game = Game.flipLock(id,state)
      Memory.GameBackup.save(socket.assigns[:name], game)
      socket = socket
               |> assign(:game, game)
      {:reply, {:ok, %{ "game" => game}}, socket}

  end

  def handle_in("lastGrind", %{"id" => id,"value" => value}, socket) do

    state = socket.assigns[:game]
    game = Game.lastGrind(id,value,state)
    Memory.GameBackup.save(socket.assigns[:name], game)
    socket = socket
             |> assign(:game, game)

    {:reply, {:ok, %{ "game" => game}}, socket}

  end

  def handle_in("setMatch", %{"id" => id,"last_id" => last_id}, socket) do

    state = socket.assigns[:game]
    game = Game.setMatch(id,last_id,state)
    Memory.GameBackup.save(socket.assigns[:name], game)
    socket = socket
             |> assign(:game, game)

    {:reply, {:ok, %{ "game" => game}}, socket}

  end

  def handle_in("setNoMatch", %{"id" => id,"last_id" => last_id}, socket) do

    state = socket.assigns[:game]
    game = Game.setNoMatch(id,last_id,state)
    Memory.GameBackup.save(socket.assigns[:name], game)
    socket = socket
             |> assign(:game, game)

    {:reply, {:ok, %{ "game" => game}}, socket}

  end
  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (games:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
