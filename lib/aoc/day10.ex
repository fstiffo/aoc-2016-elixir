defmodule Aoc.Day10 do
  @moduledoc false

  import Aoc.Utils

  def run(1), do: solve1(get_input(10))
  def run(2), do: solve2(get_input(10))

  def solve1(input) do
    input
    |> read_instructions
    |> zooming_around()

    :ets.delete(:instructions)
  end

  def read_instructions(t) do
    :ets.new(:instructions, [:set, :protected, :named_table])

    String.split(t, "\n")
    |> Enum.map(&String.split/1)
    |> Enum.reduce(%{}, fn instr, devs ->
      case instr do
        ["value", mc, "goes", "to", "bot", bot] ->
          Map.put(
            devs,
            "bot#{bot}",
            case Map.get(devs, "bot#{bot}") do
              nil -> [String.to_integer(mc)]
              b -> [String.to_integer(mc) | b]
            end
          )

        ["bot", bot, "gives", "low", "to", l_dest, l_n, "and", "high", "to", h_dest, h_n] ->
          :ets.insert(
            :instructions,
            {"bot" <> bot, [low_to: l_dest <> l_n, high_to: h_dest <> h_n]}
          )

          devs
      end
    end)
  end

  def zooming_around(devs) do
    # IO.inspect(devs)

    two_mcs =
      Enum.filter(devs, fn
        {_, [_, _]} -> true
        {_, _} -> false
      end)

    if two_mcs == [] do
      devs
    else
      new_devs = devs

      two_mcs
      |> Enum.reduce(new_devs, fn {bot, [mc1, mc2]}, ds ->
        if [17, 61] == [mc1, mc2] or [61, 17] == [mc1, mc2], do: IO.inspect(bot)
        low = min(mc1, mc2)
        high = max(mc1, mc2)
        [{_, [low_to: low_to, high_to: high_to]}] = :ets.lookup(:instructions, bot)

        ds =
          case Map.get(ds, low_to) do
            nil -> Map.put(ds, low_to, [low])
            b -> Map.put(ds, low_to, [low | b])
          end

        ds =
          case Map.get(ds, high_to) do
            nil -> Map.put(ds, high_to, [high])
            b -> Map.put(ds, high_to, [high | b])
          end

        Map.put(ds, bot, [])
      end)
      |> zooming_around
    end
  end

  def solve2(input) do
    devs =
      input
      |> read_instructions
      |> zooming_around()

    [mc0] = Map.get(devs, "output0")
    [mc1] = Map.get(devs, "output1")
    [mc2] = Map.get(devs, "output2")
    IO.inspect(mc0 * mc1 * mc2)

    :ets.delete(:instructions)
  end
end
