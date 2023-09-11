defmodule BikeShop.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias BikeShop.Carts.Server.CartSessionServer

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BikeShopWeb.Telemetry,
      # Start the Ecto repository
      BikeShop.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: BikeShop.PubSub},
      # Start Finch
      {Finch, name: BikeShop.Finch},
      # Start the Endpoint (http/https)
      BikeShopWeb.Endpoint,
      CartSessionServer
      # Start a worker by calling: BikeShop.Worker.start_link(arg)
      # {BikeShop.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BikeShop.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BikeShopWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
