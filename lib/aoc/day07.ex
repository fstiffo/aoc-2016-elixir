defmodule Aoc.Day07 do
  @moduledoc false

  import Aoc.Utils

  def run(1), do: solve1(get_input(7))
  def run(2), do: solve2(get_input(7))

  def solve1(input) do
    abba = ~r/(.)(?!\1)(.)\2\1/
    # A regex that matches an ABBA sequence
    abba_within_sqrbrkts = ~r/\[[^\]]*(.)(?!\1)(.)\2\1.*\]/
    # A regex that matches an hypernet sequence
    String.split(input, "\n")
    |> Enum.filter(&(not String.match?(&1, abba_within_sqrbrkts)))
    |> Enum.filter(&String.match?(&1, abba))
    |> length()
  end

  def all_ab(t), do: all_ab([], t)

  def all_ab(l, t) do
    # Extract all AB of an ABA sequence, present in the string t
    aba = ~r/([^\s])(?!\1)([^\s])\1/
    # A regex that matches an ABA sequence
    capture = Regex.run(aba, t, capture: :first, return: :index)

    if !capture do
      l
    else
      [{start, _}] = capture
      ab = [String.at(t, start), String.at(t, start + 1)]
      {_, rest} = String.split_at(t, start + 1)
      all_ab([ab | l], rest)
    end
  end

  def supports_ssl?(t) do
    hypernet_seq = ~r/\[[^\]]+\]/
    # A regex that matches a hyper sequence
    hypernet_sequences =
      Regex.scan(hypernet_seq, t)
      |> List.flatten()

    all_ab(String.replace(t, hypernet_seq, " "))
    |> Enum.map(fn [a, b] ->
      {_, bab} = Regex.compile(b <> a <> b)
      # A regex that matches a BAB sequence
      hypernet_sequences
      |> Enum.map(&String.match?(&1, bab))
      |> Enum.any?()
    end)
    |> Enum.any?()
  end

  def solve2(input) do
    String.split(input, "\n") |> Enum.filter(&supports_ssl?/1) |> length()
  end
end
