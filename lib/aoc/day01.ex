defmodule Aoc.Day01 do
  @moduledoc false

  import Aoc.Utils
  import PipeTo

  def run(1), do: solve1(get_input(1))
  def run(2), do: solve2(get_input(1))

  def solve1(input) do
    String.split(input, ", ", trim: true)
    ~> Enum.reduce(_, {{0, 0}, :north}, fn e, acc ->
      turn = String.first(e)
      blocks = String.to_integer(String.slice(e, 1..10))

      case {turn, acc} do
        {"R", {{x, y}, :north}} -> {{x + blocks, y}, :east}
        {"R", {{x, y}, :east}} -> {{x, y - blocks}, :south}
        {"R", {{x, y}, :south}} -> {{x - blocks, y}, :west}
        {"R", {{x, y}, :west}} -> {{x, y + blocks}, :north}
        {"L", {{x, y}, :north}} -> {{x - blocks, y}, :west}
        {"L", {{x, y}, :west}} -> {{x, y - blocks}, :south}
        {"L", {{x, y}, :south}} -> {{x + blocks, y}, :east}
        {"L", {{x, y}, :east}} -> {{x, y + blocks}, :north}
        _ -> acc
      end
    end)
    |> (fn {{x, y}, _} -> abs(x) + abs(y) end).()
  end

  def solve2(input) do
  end
end
