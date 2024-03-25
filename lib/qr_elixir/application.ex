defmodule QrElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      QrElixirWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:qr_elixir, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: QrElixir.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: QrElixir.Finch},
      # Start a worker by calling: QrElixir.Worker.start_link(arg)
      # {QrElixir.Worker, arg},
      # Start to serve requests, typically the last entry
      QrElixirWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: QrElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    QrElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
