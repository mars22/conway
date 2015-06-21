
defmodule ConwayGameTest do
  alias Conway.Game

  use ExUnit.Case ,async: true



  test "create 3X3  game" do
    {:ok, %Game{data: game}} = Game.new(3)
    assert  is_tuple(game)
    assert  tuple_size(game) == 3
  end

  test "create  game from  input" do
    input_game = [size: 3, init: [{1,1},{1,2}]]

    assert {:ok, %Conway.Game{data: { {0,0,0},
                                      {0,1,1},
                                      {0,0,0}}}} == Game.new(input_game)
  end

  test "get size of game" do
    input_game =
    {{0,0,0},
    {0,1,0},
    {0,0,0}}
    assert Game.size(input_game) == 3
  end

  test "get single cell" do
    input_game =
    {{0,0,0},
    {0,1,0},
    {0,0,0}}
    assert Game.cell_state(1, 1, input_game) == 1

    input1_game =
    {{0,0,0},
    {0,0,1},
    {0,0,0}}
    assert Game.cell_state(1, 1, input1_game) == 0
  end

  test "get number of living neighbours cells" do
    input_game =
    {{0,0,1},
    {0,1,1},
    {0,0,1}}
    assert Game.nbr_of_live_neighbours(1, 1, input_game) == 3

    input1_game =
    {{0,0,0},
    {0,1,0},
    {0,0,0}}
    assert Game.nbr_of_live_neighbours(1, 1, input1_game) == 0
  end


  test "Game.new generate diffrent games" do
    assert Game.new(4)!=Game.new(4)
  end


  test "game is ended when prev and next game is the same" do

    init_game =%Game
                  {
                    data:
                      {{0,0,0},
                      {0,1,0},
                      {0,0,0}}
                  }

    {_,next_game} = Game.next(init_game)

    assert {:ended,_} = Game.next(next_game)

  end


  test "Blinker" do
    input_game =%Game
                {
                  data:
                    {{0,1,0},
                    {0,1,0},
                    {0,1,0}}
                }
    assert {:ok, %Game{data: {{0,0,0},
                      {1,1,1},
                      {0,0,0}}}}== Game.next(input_game)
  end


end
