defmodule Aoc.Day10 do
  @moduledoc false

  import Aoc.Utils

  def run(1), do: solve1(get_input(10))
  def run(2), do: solve2(get_input(10))

  def solve1(input) do
    read_instructions(input)
    # :ets.delete(:instructions)
  end

  defmodule Bot do
    defstruct [:low, :high]
  end

  defmodule InOut do
    defstruct [:mc]
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
              nil -> struct(Bot, %{low: mc})
              b -> struct(b, %{high: mc})
            end
          )

        ["bot", bot, "gives", "low", "to", l_dest, l_n, "and", "high", "to", h_dest, h_n] ->
          :ets.insert(:instructions, {bot, [to_low: l_dest <> l_n, to_high: h_dest <> h_n]})
          devs
      end
    end)
  end

  def run(devs) do
    two_mcs =
      Enum.filter(devs, fn
        {_, %{high: h, low: l}} -> not is_nil(l) and not is_nil(h)
        {_, %{mc: _}} -> false
      end)

    if two_mcs == [] do
      devs
    else
      new_devs = devs

      two_mcs
      |> Enum.reduce(new_devs, fn {bot, _}, ds ->
        {_, [to_low: to_low, to_high: to_high]} = :ets.lookup(:instructions, bot)
        to_low_d = Map.get(devs, to_low)
        to_high_d = Map.get(devs, to_low)

        Map.put(new_devs, )
      end)
    end
  end

  def solve2(input) do
  end
end
