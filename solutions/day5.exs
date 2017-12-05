defmodule Trampoline do
  def count_jumps(instructions, offset \\ fn _ -> 1 end, index \\ 0, count \\ 0)
  def count_jumps(instructions, offset, index, count)
    when index < length(instructions) and index >= 0 do
      # IO.inspect instructions, label: "The list is"
      # IO.puts "Current index #{index}, current value #{Enum.at(instructions, index)}, count #{count}"
      count_jumps(
        Enum.slice(instructions, 0, index) ++
          [Enum.at(instructions, index) + offset.(Enum.at(instructions, index))] ++
          Enum.slice(instructions, index + 1, length(instructions)),
        offset,
        Enum.at(instructions, index) + index,
        count + 1
      )
  end
  def count_jumps(_instructions, _offset, _index, count), do: count
end

{:ok, input} = File.read("day5.txt")

offset = fn
  value when value > 2 -> -1
  _value when true -> 1
end

common = input
  |> String.trim
  |> String.split
  |> Enum.map(&String.to_integer/1)

part1 = common
  |> Trampoline.count_jumps

part2 = common
  |> Trampoline.count_jumps(offset)

IO.puts "Part 1: #{part1}"
IO.puts "Part 2: #{part2}"
