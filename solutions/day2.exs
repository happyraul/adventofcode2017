defmodule Pipeline do
  def divisible?(subject, [ head | _tail ]) when rem(head, subject) == 0 do
    head
  end
  def divisible?(subject, [ _head | tail ]) do
    divisible?(subject, tail)
  end
  def divisible?(_subject, []), do: false

  def find_divisible([ head | tail ]) do
    cond do
      divisible?(head, tail) -> div(divisible?(head, tail), head)
      true -> find_divisible(tail)
    end
  end
end

input = String.trim(elem(File.read("day2.txt"), 1))

common = String.trim(elem(File.read("day2.txt"), 1))
  |> fn inp -> String.split(inp, "\n") end.()
  |> Enum.map(&String.split/1)
  |> Enum.map(fn list -> Enum.map(list, &String.to_integer/1) end)

part1 = common
  |> Enum.map(fn list -> Enum.max(list) - Enum.min(list) end)

part2 = common
  |> Enum.map(&Enum.sort/1)
  |> Enum.map(&Pipeline.find_divisible/1)

part1 = Enum.sum(part1)
part2 = Enum.sum(part2)

IO.puts "Part 1: #{part1}"
IO.puts "Part 2: #{part2}"

