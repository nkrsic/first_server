# FirstServer

Small HTTP server built with Plug and Cowboy.

## Run

Install dependencies and start the server with:

```sh
mix deps.get
mix run --no-halt
```

Then visit <http://localhost:4000/>. The port defaults to `4000` and can be
changed with the `PORT` environment variable:

```sh
PORT=8080 mix run --no-halt
```

Run the tests with:

```sh
mix test
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `first_server` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:first_server, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/first_server>.

## Implementation Summary

Implemented a basic supervised HTTP server using Plug and Cowboy.

- Added `plug_cowboy ~> 2.7` and fetched dependencies.
- Added application supervision in `lib/first_server/application.ex`.
- Added `/` and 404 routing in `lib/first_server.ex`.
- Added router tests and updated usage instructions.
- Configured the port through `PORT`, defaulting to `4000`.

Validation passed: formatting check, 4 tests, and live HTTP checks for both 200
and 404 responses.

Hex reported advisories for the currently resolved `cowlib 2.20.0`, which is
also the latest available release.

### Commands to run against server

```
curl -i http://localhost:4000/
```

```
curl -i http://localhost:4000/missing
```

Query the weather for a supported city:

```sh
curl -i "http://localhost:4000/weather?city=Toronto"
```

Supported cities are Toronto, Calgary, and Montreal. Other cities return
`400 Bad Request`.

## Server Lifecycle

`--no-halt` is not a workaround. It is the idiomatic way to run a long-lived
application with `mix run` during development or manual testing.

The application code already defines the server correctly:

- `FirstServer.Application` starts a supervision tree.
- `Plug.Cowboy` runs as a supervised child.
- The Erlang VM hosts those long-running processes.

The command controls the VM lifecycle. `mix run` is generally intended to run
code and then exit, so `--no-halt` tells it to keep the VM alive:

```sh
mix run --no-halt
```

For production, build a Mix release and run that instead:

```sh
mix release
_build/prod/rel/first_server/bin/first_server start
```

A release can be managed by a service manager, container runtime, or init
system and remains running without manually passing `--no-halt`. The
application code does not need a special loop to keep the server alive.