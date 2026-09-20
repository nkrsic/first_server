defmodule FirstServer.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: FirstServer.Router, options: [port: port()]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: FirstServer.Supervisor)
  end

  defp port do
    System.get_env("PORT", "4000") |> String.to_integer()
  end
end
