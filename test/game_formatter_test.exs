defmodule GameFormatterTest do
  use ExUnit.Case
  alias Conway.GameFormatter, as: GF
  alias Conway.Game

  test "format single row" do
    result = GF.format_row({0,0,1,0,0})
    assert result == "\s\s\s\s#\s\s\s\s"
  end

  test "format game" do
    game = %Game{
      data: {
          {0,0,1,0,0},
          {0,0,1,0,0},
          {0,0,1,0,0},
          {0,0,1,0,0},
          {0,0,1,0,0}

      }}

      formated_game =
      """
      \s\s\s\s#\s\s\s\s
      \s\s\s\s#\s\s\s\s
      \s\s\s\s#\s\s\s\s
      \s\s\s\s#\s\s\s\s
      \s\s\s\s#\s\s\s\s
      """

      assert GF.format(game) == formated_game
  end
end
