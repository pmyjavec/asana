defmodule Asana do
  use Application
  use Supervisor

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do

    children = [
      # Define workers and child supervisors to be supervised
      Plug.Adapters.Cowboy.child_spec(:http, Asana.API , [], [port: Application.get_env(:asana, :port)]),
      supervisor(Asana.Repo, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Asana.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
