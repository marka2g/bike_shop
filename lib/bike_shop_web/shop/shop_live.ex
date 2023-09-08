defmodule BikeShopWeb.ShopLive do
  use BikeShopWeb, :live_view
  alias BikeShop.Bikes
  alias BikeShopWeb.ShopLive.Bike

  def mount(_params, _session, socket) do
    socket =
      socket
      |> list_bikes()

    {:ok, socket}
  end

  def list_bikes(socket) do
    assign(socket, bikes: Bikes.list_bikes())
  end
end
