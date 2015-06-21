defmodule Conway.CLI do
  @moduledoc """
  Handle command line parsing and create new Conaway's Game of Life.
  """

  alias Conway.GameFormatter, as: GF
  alias Conway.Game

  require Logger


  def main(argv) do
    parse_args(argv)
    |>process
  end

  @default_game_size 5

  @doc """
  --help, -h returns :help
  --size game_size returns game size
  --init "r,c .." r-row, c-column where set cell
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
      {[size: game_size,init: states],_,_}   -> [size: game_size, init: parse_init_state(states)]
      {_,_,_}                   -> @default_game_size
    end
  end

  defp parse_init_state(states) do
    String.split(states,~r/\s/)
    |>Enum.map(fn(state)->
      case String.split(state,",") do
        [r,c] -> {String.to_integer(r),String.to_integer(c)}
        [] -> {}
      end

    end)
  end



  def process(:help) do
    IO.puts """
    usage: conway --size <game_size> [ game_size | #{@default_game_size} ]
                  --init "r,c r1,c1 ..."
    """
    System.halt(0)
  end

  def process([size: _, init: _]=init_state) do
    Game.new(init_state)
    |> run_game
  end


  def process(game_size) do
    Game.new(game_size)
    |> run_game
  end



  defp run_game({:ok,game}) do
    IO.puts GF.format(game)
    run_game(Game.next(game))
  end

  defp run_game({:ended,_}) do
    IO.puts "END"
  end









end
