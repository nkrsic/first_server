defmodule FirstServer do
  @moduledoc """
  Documentation for `FirstServer`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> FirstServer.hello()
      :world

  """
  def hello do
    :world
  end
end

defmodule FirstServer.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Hello from FirstServer!\n")
  end

  match _ do
    send_resp(conn, 404, "Not found\n")
  end
end
