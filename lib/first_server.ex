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

  @weather %{
    "Toronto" => "sunny",
    "Calgary" => "cloudy",
    "Montreal" => "overcast"
  }

  get "/" do
    send_resp(conn, 200, "Hello from FirstServer!\n")
  end

  get "/weather" do
    conn = fetch_query_params(conn)

    case Map.fetch(@weather, conn.query_params["city"]) do
      {:ok, weather} ->
        send_resp(conn, 200, "The weather in #{conn.query_params["city"]} is #{weather}.\n")

      :error ->
        send_resp(conn, 400, "Unknown city.\n")
    end
  end

  match _ do
    send_resp(conn, 404, "Not found\n")
  end
end
