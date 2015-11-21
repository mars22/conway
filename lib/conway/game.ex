defmodule Conway.Game do

  require Logger

  defstruct data: nil
  @type t :: %__MODULE__{data: tuple}

  def new([game_size: game_size, init: init_state]) when is_list(init_state) do

    game_data = generate_game(game_size, &set_cell_form_init_state/3,init_state)

    {:ok, %__MODULE__{data: game_data}}
  end


  def new(game_size) do
    :random.seed(:erlang.now)
    game_data = generate_game(
      game_size, fn(_,_,_) -> :random.uniform(2)-1  end
    )
    {:ok, %__MODULE__{data: game_data}}
  end


  defp generate_game(game_size, make_cell, prev_game \\ nil) do
    for r <- 0..game_size-1 do
      for c <- 0..game_size-1 do
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

  defp set_cell_form_init_state(r, c, init_state) do
    if {r,c} in init_state, do: 1, else: 0
  end

  def size(game) when is_tuple(game) do
    tuple_size(game)
  end


  def next(%__MODULE__{ data: prev_data}) do
    next_data = generate_game(size(prev_data),&next_game_cell/3 ,prev_data)
    case prev_data == next_data do
        true -> {:ended, %__MODULE__{data: next_data}}
        false -> {:ok, %__MODULE__{data: next_data}}
    end

  end

  defp next_game_cell(r, c, prev_game) do
    case {cell_state(r, c, prev_game),nbr_of_live_neighbours(r, c, prev_game)} do
      {1, 2} -> 1
      {1, 3} -> 1
      {0, 3} -> 1
      {_, _} -> 0

    end
  end

  def cell_state(r, c, game) do
    elem(game,r) |> elem c
  end

  def nbr_of_live_neighbours(r, c, game) do
      for x <- (r-1)..(r+1),
          y <- (c-1)..(c+1),
          (

            x in 0..(size(game) - 1) and
            y in 0..(size(game) - 1) and
            (x != r or y != c) and
            cell_state(x,y,game)==1

          ) do
            1
          end |> Enum.sum
  end
end
