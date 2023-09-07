defmodule BikeShopWeb.ShopLive do
  use BikeShopWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>Bikes Of Burning Man</div>
    """
  end
end
