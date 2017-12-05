defmodule Passphrase do
  def valid?(phrases, seen \\ MapSet.new)
  def valid?([ head | tail ], seen) do
    cond do
      MapSet.member?(seen, head) -> false
      true -> valid?(tail, MapSet.put(seen, head))
    end
  end
  def valid?([], _seen), do: true

  def make_list(<< head :: integer, tail :: bitstring >>) do
    [ head | make_list(tail) ]
  end
  def make_list(<<>>), do: []

  def has_anagram?(phrases, seen \\ MapSet.new)
  def has_anagram?([ head | tail ], seen) do
    cond do
      MapSet.member?(seen, Enum.sort(head)) -> true
      true -> has_anagram?(tail, MapSet.put(seen, Enum.sort(head)))
    end
  end
  def has_anagram?([], _seen), do: false
end

{:ok, input} = File.read("day4.txt")

common = input
  |> String.trim
  |> String.split("\n")
  |> Enum.map(&String.split/1)

part1 = common
  |> Enum.filter(&Passphrase.valid?/1)
  |> length

part2 = common
  |> Enum.map(fn word_list -> Enum.map(word_list, &Passphrase.make_list/1) end)
  |> Enum.filter(fn word_list -> not Passphrase.has_anagram?(word_list) end)
  |> length

IO.puts "Part 1: #{part1}"
IO.puts "Part 2: #{part2}"
