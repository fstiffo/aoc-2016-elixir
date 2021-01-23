defmodule Aoc.Day06 do
  @moduledoc false

  import Aoc.Utils

  def run(1), do: solve1(get_input(6))
  def run(2), do: solve2(get_input(6))

  def solve1(input) do
    get_columns(input) |> Enum.map(&most_common/1)
  end

  def solve2(input) do
    get_columns(input) |> Enum.map(&least_common/1)
  end

  def get_columns(input) do
    String.split(input, "\n")
    |> Enum.map(&String.to_charlist/1)
    |> get_columns([[], [], [], [], [], [], [], []])
  end

  def get_columns([], columns), do: columns

  def get_columns([[c1, c2, c3, c4, c5, c6, c7, c8] | t], [cs1, cs2, cs3, cs4, cs5, cs6, cs7, cs8]) do
    get_columns(t, [
      [c1 | cs1],
      [c2 | cs2],
      [c3 | cs3],
      [c4 | cs4],
      [c5 | cs5],
      [c6 | cs6],
      [c7 | cs7],
      [c8 | cs8]
    ])
  end

  def most_common(l) do
    l
    |> Enum.reduce(Map.new(), fn e, acc -> Map.update(acc, e, 1, &(&1 + 1)) end)
    |> Enum.sort_by(fn {_, v} -> v end, :desc)
    |> List.first()
    |> elem(0)
  end

  def least_common(l) do
    l
    |> Enum.reduce(Map.new(), fn e, acc -> Map.update(acc, e, 1, &(&1 + 1)) end)
    |> Enum.sort_by(fn {_, v} -> v end)
    |> List.first()
    |> elem(0)
  end
end
