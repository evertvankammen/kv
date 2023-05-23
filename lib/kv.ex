defmodule HelloWorld do
  def hello do
    receive do
      {pid, name} -> send(pid, {:ok, "Hello, #{name}!"})
      hello()
    end
  end
end
