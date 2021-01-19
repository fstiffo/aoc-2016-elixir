defmodule Aoc do
  @moduledoc """
  Documentation for `Aoc`.
  """

  @spec hello :: :world
  @doc """
  Hello world.

  ## Examples

      iex> Aoc.hello()
      :world

  """
  def hello do
    :world
  end

  def main do
    IO.puts(hello())
  end
end
