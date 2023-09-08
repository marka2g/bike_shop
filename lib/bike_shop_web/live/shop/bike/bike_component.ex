defmodule BikeShopWeb.ShopLive.BikeComponent do
  use BikeShopWeb, :live_component

  defp bike_details(assigns) do
    ~H"""
    <div data-role="bike-details">
      <h2 class="mb-4 text-lg"><%= @name %></h2>
      <span class="px-2 py-1 text-xs uppercase rounded-full bg-neutral-200"><%= @type %></span>
      <span class="px-2 py-1 text-xs uppercase rounded-full bg-neutral-200">
        # of seats: <%= @seats %>
      </span>
    </div>
    """
  end

  defp bike_info(assigns) do
    ~H"""
    <div data-role="bike-info" class="flex items-center justify-around mt-6">
      <span class="text-lg font-semibold"><%= @price %></span>
      <button
        phx-click="add"
        phx-target={@myself}
        class="px-6 py-1 text-purple-600 transition border-2 border-purple-600 rounded-full hover:bg-purple-600 hover:text-neutral-100"
      >
        <span>+ add to cart</span>
      </button>
    </div>
    """
  end
end
