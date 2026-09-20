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

  test "GET /weather returns the weather for a supported city" do
    expected_weather = %{
      "Toronto" => "sunny",
      "Calgary" => "cloudy",
      "Montreal" => "overcast"
    }

    for {city, weather} <- expected_weather do
      conn = conn(:get, "/weather?city=#{city}") |> FirstServer.Router.call([])

      assert conn.status == 200
      assert conn.resp_body == "The weather in #{city} is #{weather}.\n"
    end
  end

  test "GET /weather returns an error for an unsupported city" do
    conn = conn(:get, "/weather?city=Vancouver") |> FirstServer.Router.call([])

    assert conn.status == 400
    assert conn.resp_body == "Unknown city.\n"
  end

  test "unknown routes return 404" do
    conn = conn(:get, "/missing") |> FirstServer.Router.call([])

    assert conn.status == 404
    assert conn.resp_body == "Not found\n"
  end
end
