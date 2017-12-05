require Integer
input = 361527

next_odd = fn
  val when Integer.is_odd val -> val
  val -> val + 1
end

corner_root = fn
  val -> next_odd.(round(Float.ceil(:math.sqrt(val))))
end

br = fn
  val -> corner_root.(val) * corner_root.(val)
end

ring = fn
  val -> div(corner_root.(val) - 1, 2)
end

edge_length = corner_root

corners = fn
  val -> [br.(val), br.(val) - (edge_length.(val) - 1), br.(val) - 2 * (edge_length.(val) - 1), br.(val) - 3 * (edge_length.(val) - 1)]
end

center = fn
  corner -> corner - div(corner_root.(corner) - 1, 2)
end

centers = fn
  corners -> Enum.map(corners, center)
end

distance_to_center = fn
  val -> corners.(val) |> centers.() |> Enum.map(&(Kernel.abs(&1 - val))) |> Enum.min
end

part1 = distance_to_center.(input) + ring.(input)

defmodule Grid do
  def make_value(opts \\ []) do
    defaults = [e: 0, ne: 0, n: 0, nw: 0, w: 0, sw: 0, s: 0, sw: 0] 
    opts = Keyword.merge(defaults, opts) |> Enum.into(%{})
    %{pos: pos, value: value, e: e, ne: ne, n: n, nw: nw, w: w, sw: sw, s: s, sw: sw} = opts
  end

  def move_right(%{pos: {x, y}, value: value, e: e, ne: ne, n: n, nw: nw, w: w, sw: sw, s: s, sw: sw}) do
    make_value(pos: {x + 1, y}, value: value + , e: e, ne: ne, n: n, nw: nw, w: w, sw: sw, s: s, sw: sw}
  end
end

#move_right = fn
 # left -> 
#br = Stream.unfold({3, 5}, fn {f1, f2} -> {f1 * f1, {f2, f2 + 2}} end)
#bl = br |> Enum.take(5) |> Enum.map(fn i -> i - round(:math.sqrt(i)) + 1 end)


IO.puts "Part 1: #{part1}"
#IO.puts "Part 2: #{part2}"

