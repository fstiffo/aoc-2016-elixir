defmodule Aoc.Utils do
  @moduledoc false

  @base "inputs"

  @spec get_input(integer, boolean) :: binary
  def get_input(day, test \\ false) do
    day_str = day |> Integer.to_string() |> String.pad_leading(2, "0")
    input = if !test, do: day_str, else: day_str <> "-test"
    File.read!(Path.join(@base, "day#{input}.txt"))
  end
end
