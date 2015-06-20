defmodule Conway.GameFormatter do
  @moduledoc """
  nicly format game
  """
  alias Conway.Game


  def format(%Game{ data: game }) do
    result = Tuple.to_list(game)
    |>Enum.map_join("\n",&format_row/1)
    result <> "\n"
  end

  def format_row(row) when is_tuple(row) do
    row
    |> Tuple.to_list
    |> Enum.map_join(" " ,fn c -> if c==1, do: "#", else: "_" end)
  end
end
