defmodule Conway.Game do

  require Logger

  defstruct data: nil
  @type t :: %Conway.Game{data: tuple}

  def new(input_game) when is_list(input_game) do
    %__MODULE__{data: make_tuples(input_game)}
  end


  def new(size) do
    game_data = generate_game(size, fn(_,_,_) -> :random.uniform(2)-1  end )
    %__MODULE__{data: game_data}
  end


  defp generate_game(size, make_cell, prev_game \\ nil) do
    for r <- 0..size-1 do
      for c <- 0..size-1 do
        make_cell.(r,c,prev_game)
      end
    end
    |> make_tuples
  end



  defp make_tuples(list_of_lists) do
    list_of_lists
    |> Enum.map(&List.to_tuple/1)
    |> List.to_tuple
  end

  def size(game) when is_tuple(game) do
    tuple_size(game)
  end


  def next(%__MODULE__{ data: prev_data}) do
    next_data = generate_game(size(prev_data),&next_game/3 ,prev_data)
    case prev_data == next_data do
        true -> {:ended, %__MODULE__{data: next_data}}
        false -> {:ok, %__MODULE__{data: next_data}}
    end

  end

  defp next_game(r, c, prev_game) do
    case {get_cell(r, c, prev_game),nbr_of_live_neighbours(r, c, prev_game)} do
      {1, 2} -> 1
      {1, 3} -> 1
      {0, 3} -> 1
      {_, _} -> 0

    end
  end

  def get_cell(r, c, game) do
    elem(game,r) |> elem c
  end

  def nbr_of_live_neighbours(r, c, game) do
      for x <- (r-1)..(r+1),
          y <- (c-1)..(c+1),
          (

            x in 0..(size(game) - 1) and
            y in 0..(size(game) - 1) and
            (x != r or y != c) and
            get_cell(x,y,game)==1

          ) do
            1
          end |> Enum.sum
  end
end
