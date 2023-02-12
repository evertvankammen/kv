defmodule DoSomething do
   def print(1) do
    IO.puts("het is een 1")
  end

  def print(a) when is_integer(a) and a <10  do
    IO.puts(a)
  end

  def print(a) when is_integer(a) do
    IO.puts(a)
    IO.puts("is groter dan 10 ")
  end

   def print(a) do
     IO.puts(a)
   end


   # A function head declaring defaults
   def join(a, b \\ nil, sep \\ " ")

   def join(a, b, _sep) when is_nil(b) do
     a
   end

   def join(a, b, sep) do
     a <> sep <> b
   end






end
