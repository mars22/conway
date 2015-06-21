defmodule Conway.CLI do
  @moduledoc """
  Handle command line parsing and create new Conaway's Game of Life.
  """

  alias Conway.GameFormatter, as: GF
  alias Conway.Game

  import :timer, only: [sleep: 1]
  require Logger


  def main(argv) do
    parse_args(argv)
    |>process
  end

  @default_game_size 5
  @default_repeat_times 10

  @doc """
  --help, -h returns :help
  --size game_size returns game size
  no option returns default game size
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean,
                                                size: :integer],
                                      aliases: [h: :help])

    case parse do
      {[help: true],_,_}        -> :help
      {[h: true],_,_}           -> :help
      {[size: game_size],_,_}   -> game_size
      {_,_,_}                   -> @default_game_size
    end
  end

  def process(:help) do
    IO.puts """
    usage: conway --size <game_size> [ game_size | #{@default_game_size} ]
    """
    System.halt(0)
  end

  def process(game_size) do
    Game.new(game_size)
    |> start
  end

  def start({:ok,game}) do
    IO.puts GF.format(game)
    
    start(Game.next(game))
  end

  def start({:ended,_}) do
    IO.puts "END"
  end









end
