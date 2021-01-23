defmodule Aoc.Day05 do
  @moduledoc false

  import Aoc.Utils

  def run(1), do: solve1(get_input(5))
  def run(2), do: solve2(get_input(5))

  def solve1(input) do
    password1(input)
  end

  def solve2(input) do
  end

  # :crypto.hash(:md5 , "abc3231929") |> Base.encode16()

  def password1(door_id) do
    password1(door_id, [], 0)
  end

  def password1(_, l, _) when length(l) == 8, do: List.to_string(l)

  def password1(door_id, l, acc) do
    hash = :crypto.hash(:md5, door_id <> Integer.to_string(acc)) |> Base.encode16()

    if String.slice(hash, 0..4) == "00000" do
      password1(door_id, l ++ [String.at(hash, 5)], acc + 1)
    else
      password1(door_id, l, acc + 1)
    end
  end
end
