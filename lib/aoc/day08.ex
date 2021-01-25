defmodule Aoc.Day08 do
  @moduledoc false

  import Aoc.Utils

  def run(1), do: solve1(get_input(8))
  def run(2), do: solve2(get_input(8))

  def solve1(input) do
    String.split(input, "\n")
    |> Enum.map(&String.split/1)
    |> Enum.reduce(Matrex.zeros(6, 50), &exec/2)
    |> Enum.sum()
  end

  def exec(["rect", size], screen) do
    [cols, rows] = String.split(size, "x") |> Enum.map(&String.to_integer/1)
    {scr_rows, scr_cols} = Matrex.size(screen)

    Matrex.new(scr_rows, scr_cols, fn row, col ->
      if row <= rows and col <= cols, do: 1, else: screen[row][col]
    end)
  end

  def exec(["rotate", "column", col, "by", by], screen) do
    [_, {col, _}] = String.split(col, "=") |> Enum.map(&Integer.parse/1)
    by = String.to_integer(by)

    rotated_col =
      [Matrex.column_to_list(screen, col + 1) |> rotate(by)] |> Matrex.new() |> Matrex.transpose()

    Matrex.set_column(screen, col + 1, rotated_col)
  end

  def exec(["rotate", "row", row, "by", by], screen) do
    [_, {row, _}] = String.split(row, "=") |> Enum.map(&Integer.parse/1)
    by = String.to_integer(by)

    rotated_row = [Matrex.row_to_list(screen, row + 1) |> rotate(by)] |> Matrex.new()
    set_row(screen, row + 1, rotated_row)
  end

  def set_row(m, n, m_row) do
    range1 =
      case 1..(n - 1) do
        n..n -> n
        r -> r
      end

    range2 =
      case (n + 1)..elem(Matrex.size(m), 0) do
        n..n -> n
        r -> r
      end

    cond do
      n == 1 -> Matrex.new([[m_row], [m[range2]]])
      n == elem(Matrex.size(m), 0) -> Matrex.new([[m[range1]], [m_row]])
      true -> Matrex.new([[m[range1]], [m_row], [m[range2]]])
    end
  end

  def rotate([], _), do: []
  def rotate(l, 0), do: l

  def rotate(l, 1) do
    {l1, [last]} = Enum.split(l, -1)
    [last | l1]
  end

  def rotate(l, n) do
    {l1, [last]} = Enum.split(l, -1)
    rotate([last | l1], n - 1)
  end

  def solve2(input) do
    String.split(input, "\n")
    |> Enum.map(&String.split/1)
    |> Enum.reduce(Matrex.zeros(6, 50), &exec/2)
    |> Matrex.heatmap(:mono8)
  end
end
