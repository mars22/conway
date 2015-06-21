defmodule Conway.GameServer do
  alias Conway.Game

  use GenServer

  #####
  # External api



  def start_link(game_size) do
    GenServer.start_link(__MODULE__, game_size, name: __MODULE__)
  end

  def stop() do
      GenServer.call(__MODULE__, :stop)
  end

  def next_game() do
    GenServer.call(__MODULE__, :next_game)
  end


  ######
  # GenServer implementation

  def init(game_size) do
    new_game = Game.new(game_size)
    {:ok, new_game}
  end

  def handle_call(:next_game, _from, {_, game}=current_game) do
    {:reply, current_game, Game.next(game)}
  end

  def handle_call(:stop, _from, state) do
   {:stop, :normal, :ok, state}
  end

end
