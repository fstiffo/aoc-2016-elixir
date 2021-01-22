defmodule Aoc.Day02 do
  @moduledoc false

  import Aoc.Utils

  @spec run(1 | 2) :: any
  def run(1), do: solve1(get_input(2))
  def run(2), do: solve2(get_input(2))

  def solve1(input) do
    String.split(input, "\n")
    |> Enum.scan(5, fn e, acc -> String.to_charlist(e) |> button1(acc) end)
  end

  def solve2(input) do
    String.split(input, "\n")
    |> Enum.scan(0x5, fn e, acc -> String.to_charlist(e) |> button2(acc) end)
  end

  defp button1(instrs, start) do
    Enum.reduce(instrs, start, &adjacent1/2)
  end

  defp button2(instrs, start) do
    Enum.reduce(instrs, start, &adjacent2/2)
  end

  defp adjacent1(instr, start) do
    case start do
      # The keypad is like this:
      # 1 2 3
      # 4 5 6
      # 7 8 9
      1 -> %{?U => 1, ?D => 4, ?L => 2, ?R => 1}[instr]
      2 -> %{?U => 2, ?D => 5, ?L => 1, ?R => 3}[instr]
      3 -> %{?U => 3, ?D => 6, ?L => 2, ?R => 3}[instr]
      4 -> %{?U => 1, ?D => 7, ?L => 4, ?R => 5}[instr]
      5 -> %{?U => 2, ?D => 8, ?L => 4, ?R => 6}[instr]
      6 -> %{?U => 3, ?D => 9, ?L => 5, ?R => 6}[instr]
      7 -> %{?U => 4, ?D => 7, ?L => 7, ?R => 8}[instr]
      8 -> %{?U => 5, ?D => 8, ?L => 7, ?R => 9}[instr]
      9 -> %{?U => 6, ?D => 9, ?L => 8, ?R => 9}[instr]
    end
  end

  defp adjacent2(instr, start) do
    case start do
      # The keypad is like this:
      #     1
      #   2 3 4
      # 5 6 7 8 9
      #   A B C
      #     D
      0x1 -> %{?U => 0x1, ?D => 0x3, ?L => 0x1, ?R => 0x1}[instr]
      0x2 -> %{?U => 0x2, ?D => 0x6, ?L => 0x2, ?R => 0x3}[instr]
      0x3 -> %{?U => 0x1, ?D => 0x7, ?L => 0x2, ?R => 0x4}[instr]
      0x4 -> %{?U => 0x4, ?D => 0x8, ?L => 0x3, ?R => 0x4}[instr]
      0x5 -> %{?U => 0x5, ?D => 0x5, ?L => 0x5, ?R => 0x6}[instr]
      0x6 -> %{?U => 0x2, ?D => 0xA, ?L => 0x5, ?R => 0x7}[instr]
      0x7 -> %{?U => 0x3, ?D => 0xB, ?L => 0x6, ?R => 0x8}[instr]
      0x8 -> %{?U => 0x4, ?D => 0xC, ?L => 0x7, ?R => 0x9}[instr]
      0x9 -> %{?U => 0x9, ?D => 0x9, ?L => 0x8, ?R => 0x9}[instr]
      0xA -> %{?U => 0x6, ?D => 0xA, ?L => 0xA, ?R => 0xB}[instr]
      0xB -> %{?U => 0x7, ?D => 0xD, ?L => 0xA, ?R => 0xC}[instr]
      0xC -> %{?U => 0x8, ?D => 0xC, ?L => 0xB, ?R => 0xC}[instr]
      0xD -> %{?U => 0xB, ?D => 0xD, ?L => 0xD, ?R => 0xD}[instr]
    end
  end
end
