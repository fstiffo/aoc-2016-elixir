defmodule Aoc.Day03 do
  @moduledoc false

  import Aoc.Utils

  @spec run(1 | 2) :: any
  def run(1), do: solve1(get_input(3))
  def run(2), do: solve2(get_input(3))

  def solve1(input) do
    String.split(input, "\n")
    |> Enum.map(fn x -> x |> String.split() |> Enum.map(&String.to_integer/1) |> valid end)
    |> Enum.filter(& &1)
    |> length
  end

  def solve2(input) do
  end

  defp valid([a, b, c]) do
    a + b > c and a + c > b and b + c > a
  end
end
