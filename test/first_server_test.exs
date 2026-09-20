defmodule FirstServerTest do
  use ExUnit.Case

  import Plug.Test

  doctest FirstServer

  test "greets the world" do
    assert FirstServer.hello() == :world
  end

  test "GET / returns a greeting" do
    conn = conn(:get, "/") |> FirstServer.Router.call([])

    assert conn.status == 200
    assert conn.resp_body == "Hello from FirstServer!\n"
  end

  test "unknown routes return 404" do
    conn = conn(:get, "/missing") |> FirstServer.Router.call([])

    assert conn.status == 404
    assert conn.resp_body == "Not found\n"
  end
end
