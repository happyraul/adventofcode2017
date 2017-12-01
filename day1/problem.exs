defmodule Pipeline do
  def index(pos, size, offset \\ 1)
  def index(pos, size, offset) when pos + offset < size do
    pos + offset
  end
  def index(pos, size, offset) when pos + offset >= size do
    pos + offset - size
  end

  def group(str, offset \\ 1) do
    for x <- 0..length(str) -1 do
      { Enum.at(str, x), Enum.at(str, index(x, length(str), offset)) }
    end
  end

  def add(items) when elem(items, 0) == elem(items, 1) do
    elem(items, 0) - ?0
  end
  def add(_) when true, do: 0
  
  def make_list(<< head :: integer, tail :: bitstring >>) do 
    [ head | make_list(tail) ]
  end

  def make_list(<<>>), do: []
end

input = String.trim(elem(File.read("input.txt"), 1))

part1 = String.trim(elem(File.read("input.txt"), 1))
  |> Pipeline.make_list
  |> Pipeline.group
  |> Enum.map(&Pipeline.add/1)
  |> Enum.sum

part2 = String.trim(elem(File.read("input.txt"), 1))
  |> Pipeline.make_list
  |> Pipeline.group(div(String.length(input), 2))
  |> Enum.map(&Pipeline.add/1)
  |> Enum.sum

IO.puts "Part 1: #{part1}"
IO.puts "Part 2: #{part2}"

