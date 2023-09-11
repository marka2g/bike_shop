defmodule BikeShopWeb.Admin.BikeLive.Show do
  use BikeShopWeb, :live_view

  alias BikeShop.Bikes
  alias BikeShopWeb.Admin.BikeLive.BikeForm

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bike, Bikes.get_bike!(id))}
  end

  defp page_title(:show), do: "Show Bike"
  defp page_title(:edit), do: "Edit Bike"
end
