defmodule Aoc.Day03 do
  @moduledoc false

  import Aoc.Utils

  @spec run(1 | 2) :: integer
  def run(1), do: solve1(get_input(3))
  def run(2), do: solve2(get_input(3))

  @spec solve1(binary) :: non_neg_integer
  def solve1(input) do
    String.split(input, "\n")
    |> Enum.map(fn x -> x |> String.split() |> Enum.map(&String.to_integer/1) |> valid end)
    |> Enum.filter(& &1)
    |> length
  end

  def solve2(input) do
    String.split(input, "\n")
    |> Enum.map(fn x ->
      x |> String.split() |> Enum.map(&String.to_integer/1)
    end)
    |> vertically([])
    |> Enum.map(&valid/1)
    |> Enum.filter(& &1)
    |> length
  end

  defp valid([a, b, c]) do
    # In a valid triangle, the sum of any two sides must be larger than the remaining side.

    a + b > c and a + c > b and b + c > a
  end

  defp vertically([], groups), do: groups
  # It occurs to you that triangles are specified in groups of three vertically.

  defp vertically([[a1, a2, a3], [b1, b2, b3], [c1, c2, c3] | rest], groups),
    do: vertically(rest, [[a1, b1, c1], [a2, b2, c2], [a3, b3, c3] | groups])
end
