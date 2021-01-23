defmodule Aoc.Day05 do
  @moduledoc false

  import Aoc.Utils

  def run(1), do: solve1(get_input(5))
  def run(2), do: solve2(get_input(5))

  def solve1(input) do
    password1(input)
  end

  def solve2(input) do
    password2(input)
  end

  # :crypto.hash(:md5 , "abc3231929") |> Base.encode16()

  defp password1(door_id) do
    password1(door_id, [], 0)
  end

  defp password1(_, l, _) when length(l) == 8, do: List.to_string(l)

  defp password1(door_id, l, acc) do
    hash = :crypto.hash(:md5, door_id <> Integer.to_string(acc)) |> Base.encode16()

    if String.slice(hash, 0..4) == "00000" do
      password1(door_id, l ++ [String.at(hash, 5)], acc + 1)
    else
      password1(door_id, l, acc + 1)
    end
  end

  defp password2(door_id) do
    password2(door_id, List.duplicate(nil, 8), 0)
  end

  defp password2(door_id, l, acc) do
    if not Enum.any?(l, &is_nil/1) do
      List.to_string(l)
    else
      hash = :crypto.hash(:md5, door_id <> Integer.to_string(acc)) |> Base.encode16()

      if String.slice(hash, 0..4) == "00000" do
        index = String.at(hash, 5) |> String.to_integer(16)

        if index < 8 && is_nil(Enum.at(l, index)) do
          password2(door_id, List.replace_at(l, index, String.at(hash, 6)), acc + 1)
        else
          password2(door_id, l, acc + 1)
        end
      else
        password2(door_id, l, acc + 1)
      end
    end
  end
end
