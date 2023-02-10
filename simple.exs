defmodule KV.Xxx do
  def yyy() do
    IO.puts("Hello world")
    #1 + 2
    #5 * 5
    #10 / 2

    add = fn a,b-> a + b end


    IO.puts(add.(1 , 2))

    x = 40
    case x do
      1 -> IO.puts("x is 1")
      x when x > 10 -> IO.puts("x is " <> to_string(x))
      x when x > 1 -> IO.puts("x is groter dan 2")
    end

    cond do
      x == 40 -> IO.puts("1")
      true -> IO.puts("1")

    end
  end
  def printArray([head | tail]) do
    IO.puts(to_string(head))
    printArray(tail)
  end

  def printArray(head) do
    IO.puts(to_string(head))
  end

end


x = 1
_y = 2

IO.puts(to_string(x))
{a, b, c} = {:hello, "world", 42}
IO.puts(to_string(a))
IO.puts(to_string(b))
IO.puts(to_string(c))
[head | tail] = [1, 2, 3]
IO.puts(to_string(head))
IO.puts(to_string(tail))

KV.Xxx.printArray([1,2,3])


case 1 do
  x -> IO.puts("dasdsad #{x}")
end


f = fn
  x, y when x > 0 -> x + y
  x, y -> x * y
end

IO.puts( to_string(  f.(1,3)))
IO.puts( to_string(  f.(-1,3)))


case {1,2,3} do
  {a,b,c}  when a + b + c == 6 -> IO.puts("succes")
  _ -> IO.puts("geen succes")
end


if 1==1 do
  IO.puts("always true")
else
  # not reach reachable
end

unless 1==1 do
  # not reach reachable
else
  IO.puts("always true")
end

#unicode standard uses code points, a number that is linked to an character
# ?z give a code point
#an encoding is how codepoints are stored
#UTF-8 is an encoding, code points are encoded as a series of 8-bit bytes (1 to 4 bytes)
#Grapheme consists of multiple characters, like emojis

IO.puts(String.codepoints("é"))

IO.puts("hełło" <> <<0>>) # gives the bytes

#A bitstring is a contiguous sequence of bits in memory.
# <<number::store in number of bits>>
IO.puts(<<2::2>> == <<6::2>>) # 10 == 10 the left 1 from 110 (6 decimal) is truncated
IO.puts(<<0::1, 0::1, 1::1, 1::1>> == <<3::4>>) # 0011 == 0011

# default number of bits is 8
# Binary: bitstring that is divisible by 8
# A string is a UTF-8 encoded binary
# concat <> is actually a binary concat
<<head, rest::binary>> = "banana"
IO.puts(head);
IO.puts(rest);

# However, remember that binary pattern matching works on bytes,
# so matching on the string like “über” with multibyte characters won’t match on the character,
# it will match on the first byte of that character:
<<x::utf8, _::binary>> = "über" # works because ü is a multibyte
IO.puts(x == ?ü)
#  functions are polymorphic
# charlist: 'hello' is list of code points
IO.puts('hello')

to_string('hełło')
to_charlist("hełło")

# Keyword lists, nadeel O(n)
# Keys must be atoms.
# Keys are ordered, as specified by the developer.
# Keys can be given more than once.
list = [a: 1, b: 2]
IO.puts(list[:a])

# Maps
# Maps allow any value as a key.
# Maps’ keys do not follow any ordering.
map = %{:a => 1, 2 => :b}
IO.puts(map[:a])
IO.puts(map[2])
# pattern matching
%{:a => a} = %{:a => :xxx, 2 => :b}
IO.puts(a)
b = :a
%{ ^b => :xxx} = %{:a => :xxx, 2 => :b}
IO.puts(a)

#nested structures
users = [
  john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
  mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
]

IO.puts(users[:john].name)
users = put_in users[:john].age, 31
IO.puts(users[:john].age)
users = update_in users[:mary].languages, fn languages -> List.delete(languages, "Clojure") end
