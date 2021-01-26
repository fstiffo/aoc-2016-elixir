defmodule Aoc.Day09 do
  @moduledoc false

  import Aoc.Utils

  def run(1), do: solve1(get_input(9))
  def run(2), do: solve2(get_input(9))

  def solve1(input) do
    decompress(input) |> String.length()
  end

  def decompress(t), do: decompress(t, "")
  def decompress("", d), do: d

  def decompress(t, d) do
    capture = Regex.run(~r/^([^(]*)\(([^)x]+)x([^)]+)\)(.*)$/, t)

    if is_nil(capture) do
      decompress("", d <> t)
    else
      [_, no_mrks, mrk_chars, mrk_times, rest] = capture
      {:ok, subseqs_re} = Regex.compile("^(.{" <> mrk_chars <> "})(.*)$")
      [_, subseqs, rest] = Regex.run(subseqs_re, rest)
      decompress(rest, d <> no_mrks <> String.duplicate(subseqs, String.to_integer(mrk_times)))
    end
  end

  def solve2(input) do
  end
end
