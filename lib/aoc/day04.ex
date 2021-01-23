defmodule Aoc.Day04 do
  @moduledoc false

  import Aoc.Utils

  @spec run(1 | 2) :: integer
  def run(1), do: solve1(get_input(4))
  def run(2), do: solve2(get_input(4))

  def solve1(input) do
    String.split(input, "\n")
    |> Enum.map(&parse_room/1)
    |> Enum.filter(fn r -> real_room?(r) end)
    |> Enum.map(fn [encrypted_name: _, sector_id: s, checksum: _] -> s end)
    |> Enum.sum()
  end

  def solve2(input) do
    0
  end

  def parse_room(t) do
    e = String.slice(t, 0..-12)
    s = String.slice(t, -10..-8) |> String.to_integer()
    c = String.slice(t, -6..-2)
    [encrypted_name: e, sector_id: s, checksum: c]
  end

  def real_room?(room) do
    room[:encrypted_name]
    |> String.replace("-", "")
    |> String.to_charlist()
    |> Enum.reduce(Map.new(), fn e, acc -> Map.update(acc, e, 1, &(&1 + 1)) end)
    |> Enum.sort_by(fn {k, v} -> v * 1000 + ?z - k end, :desc)
    |> Enum.take(5)
    |> Enum.map(fn {k, _v} -> k end)
    |> List.to_string() == room[:checksum]
  end
end
