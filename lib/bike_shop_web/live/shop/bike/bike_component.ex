defmodule BikeShopWeb.ShopLive.BikeComponent do
  use BikeShopWeb, :live_component
  alias BikeShop.Carts

  def handle_event("add", _, socket) do
    bike = socket.assigns.bike
    cart_id = socket.assigns.cart_id
    add_bike_to_cart(cart_id, bike)

    {:noreply,
     socket
     |> put_flash(:info, "#{bike.name} added to cart")
     |> push_redirect(to: "/")}
  end

  defp add_bike_to_cart(cart_id, bike) do
    Carts.add(cart_id, bike)
    # cart = Carts.get(cart_id)
    # send(self(), {:update_cart, cart})
  end

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
        class="px-6 py-1 text-purple-500 transition border-2 border-purple-600 rounded-full hover:bg-purple-600 hover:text-neutral-100"
      >
        <span>+ add to cart</span>
      </button>
    </div>
    """
  end
end
