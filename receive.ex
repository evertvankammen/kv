defmodule Ontvanger do
  def ontvang do
    receive do
      {:ok, msg} -> msg
      after 1_000 -> "Time is up!"
    end
  end
end
