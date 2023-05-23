defmodule Zender do

  def start do
    spawn_link(HelloWorld, :hello, [])
  end

  def post(pid,text) do
    send pid, {self(), text}
  end

end