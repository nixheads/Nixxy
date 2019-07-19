defmodule Nixxy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Nixxy.Connectors.IRC.Bot, as: IRCBot

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    # List all child processes to be supervised
    children =
      Application.get_env(:nixxy, :irc) |> Enum.map(fn bot ->
      {IRCBot, bot}
    end)

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Nixxy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
