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

[1, 2, 3] ++ [4, 5, 6] # concat 2 lists  = [1, 2, 3, 4, 5, 6] lists are linked lists length = O(n)
[1, true, 2, false, 3, true] -- [true, false] # subtract list = [1, 2, 3, true]
hd([1, 2, 3]) # 1
tl([1, 2, 3]) # tail

{:ok, "hello"} # tuple are stored contiguously in memory. length = O(1)

# types in Elixir are immutable, if changed a new value wil be created and the old one stays the same


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
# ?z gives a code point
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

# Associative data structures are able to associate a key to a certain value.

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

DoSomething.print(123)
DoSomething.print(1)

# function caption
# & capture operator, this allows named functions to be assigned to variables and be passed as arguments
fun = &DoSomething.print/1

fun.(1)

(&DoSomething.print/1).(1)
(&DoSomething.print/1).("hoi")

fun = &(&1 + 1) #&1 is first argument  == fn x -> x + 1
IO.puts(fun.(2)) #

x = 1
1 = x
defmodule Recursion do
def print_multiple_times(msg, n) when n > 0 do
  IO.puts(msg)
  print_multiple_times(msg, n - 1)
end

def print_multiple_times(_msg, 0) do
  :ok
end
end

Recursion.print_multiple_times("Hello!", 3)

Enum.map([1, 2, 3], fn x -> x * 2 end) # [2,4,6]
Enum.map(%{1 => 2, 3 => 4}, fn {k, v} -> k * v end) # [2,12]
Enum.map(1..3, fn x -> x * 2 end) # [2,4,6]
Enum.reduce(1..3, 0, &+/2) #

#All the functions in the Enum module are eager.

odd? = &(rem(&1, 2) != 0)

cond do
  odd?.(1) == true  -> IO.puts('odd')
  odd?.(1) == false -> IO.puts('even')
end

x = Enum.filter(1..100_000, odd?)
y = Enum.filter(1..100_000, &(odd?.(&1) != true))

IO.puts(Enum.reduce(x,&+/2))
IO.puts(Enum.reduce(y,&+/2))
IO.puts(Enum.reduce(1..100_000,&+/2))

# first make a list, then map (creates new list), then filter (creates new list) ,then sum()
1..100_000 |> Enum.map(&(&1 * 3)) |> Enum.filter(odd?) |> Enum.sum()

Enum.sum(Enum.filter(Enum.map(1..100_000,&(&1 * 3)), odd?)) # equal but harder te read

#Streams are lazy
1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?) |> Enum.sum

#Instead of generating intermediate lists, streams build a series of computations
#that are invoked only when we pass the underlying stream to the Enum module.
#Streams are useful when working with large, possibly infinite, collections

stream = Stream.cycle([1, 2, 3]) #infinite stream
Enum.take(stream, 10) #at this point the stream will be evaluated

stream = Stream.unfold("hełło", &String.next_codepoint/1) #excute function on list items
Enum.take(stream, 3)

stream = File.stream!("mix.exs")
IO.puts(Enum.take(stream, 2)) #prints first part, does not have to open the entire file

pid1 = spawn(fn -> 1..100_000_000 |> Enum.sum() end) # mcp  spawn
pid2 = spawn(fn -> 1..100_000_000 |> Enum.sum() end)

IO.puts("#{inspect pid1} #{Process.alive?(pid1)}")
IO.puts("#{inspect pid2} #{Process.alive?(pid2)}")


parent = self()

spawn(fn -> send(parent, {:hello, self()}) end)

receive do # mcp receive
     {:hello, pid} -> IO.puts("Got hello from #{inspect pid}") #inspect for printing
end

#spawn_link(fn -> raise "oops" end)  # mcp spawn_link

Task.start(fn -> send(parent, {:xxx, self()}) end) # mcp Task

receive do
  {:xxx, pid} -> IO.puts("Got xxx from #{inspect pid}") #inspect for printing
end

#We haven’t talked about state so far in this guide. If
#you are building an application that requires state, for example,
#to keep your application configuration, or you need to parse a file
#and keep it in memory, where would you store it?

#Processes are the most common answer to this question.
#We can write processes that loop infinitely,
#maintain state, and send and receive messages

{:ok, pid} = KV.start_link()

send(pid, {:get, :hello, self()})
Process.register(pid, :kv)
send(:kv, {:get, :hello, self()}) #proces has name :kv

#flush()

#Using processes to maintain state and name registration are very common patterns
#in Elixir applications. However, most of the time, we won’t implement those
# patterns manually as above, but by using one of the many abstractions that ship with Elixir.
# Agent is an abstraction around state
{:ok, pid} = Agent.start_link(fn -> %{} end)

Agent.update(pid, fn map -> Map.put(map, :hello, :world) end)
Agent.get(pid, fn map -> Map.get(map, :hello) end)

yorn = IO.gets("yes or no? ")

IO.puts(yorn)


{:ok, file} = File.open("hello", [:write])
IO.binwrite(file, yorn)
File.close(file)

#Elixir processes are isolated and don’t share anything by default.
#Therefore, a failure in a process will never crash or corrupt the
#state of another process.

#Links, however, allow processes to establish a relationship in case
#of failure. We often link our processes to supervisors which will
#detect when a process dies and start a new process in its place.

#spawn/1 and spawn_link/1 are the basic primitives for creating processes in Elixir