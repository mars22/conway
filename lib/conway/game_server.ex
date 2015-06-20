defmodule Conway.GameServer do
  alias Conway.Game

  use GenServer

  #####
  # External api


  def start_link(game_size) do
    new_game = Game.new(game_size)
    GenServer.start_link(__MODULE__, {:ok, new_game}, name: __MODULE__)

  end

  def next_game() do
    GenServer.call(__MODULE__, :next_game)
  end


  ######
  # GenServer implementation


  def handle_call(:next_game, _from, {:ok, game}=current_game) do
    {:reply, current_game, Game.next(game)}
  end

  def handle_call(:next_game, _from, {:ended, _}=current_game) do
    {:stop, :normal, :ok, current_game}

  end

  
end
