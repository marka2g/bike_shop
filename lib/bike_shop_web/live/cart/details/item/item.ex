defmodule BikeShopWeb.Cart.Details.Item do
  use BikeShopWeb, :live_component
  alias BikeShop.Carts

  def render(assigns) do
    ~H"""
    <div id={@id} data-role="item" class="flex items-center p-2 my-8 shadow-lg hover:bg-neutral-100">
      <img data-role="item-image" src={@item.item.image_url} alt="" class="w-16 h-16 rounded-full" />
      <div class="flex-1 ml-4">
        <h1><%= @item.item.name %></h1>
        <span><%= @item.item.type %></span>
      </div>

      <div class="flex-1" data-role="quantity">
        <div class="flex items-center">
          <button
            data-role="dec"
            data-id={@id}
            phx-click="dec"
            phx-target={@myself}
            class="p-1 m-2 font-bold bg-purple-500 rounded-2xl text-neutral-100"
          >
            -
          </button>
          <span data-role="items" data-id={@id}><%= @item.quantity %> Item(s)</span>
          <button
            data-role="inc"
            data-id={@id}
            phx-click="inc"
            phx-target={@myself}
            class="p-1 m-2 font-bold bg-purple-500 rounded-2xl text-neutral-100"
          >
            +
          </button>
        </div>
      </div>

      <div class="flex items-center flex-1" data-role="total-item">
        <span class="text-lg font-bold" data-role="price" data-id={@id}><%= @item.item.price %></span>
        <button
          phx-click="remove"
          data-role="remove"
          data-id={@id}
          phx-target={@myself}
          class="w-6 h-6 ml-2 font-bold bg-purple-500 rounded-full text-neutral-100"
        >
          &times
        </button>
      </div>
    </div>
    """
  end

  def handle_event("remove", _, socket) do
    update_cart(socket, &Carts.remove/2)
    {:noreply, socket}
  end

  def handle_event("dec", _, socket) do
    update_cart(socket, &Carts.dec/2)
    {:noreply, socket}
  end

  def handle_event("inc", _, socket) do
    update_cart(socket, &Carts.inc/2)
    {:noreply, socket}
  end

  defp update_cart(socket, function) do
    bike_id = socket.assigns.id
    cart_id = socket.assigns.cart_id
    cart = function.(cart_id, bike_id)
    send(self(), {:update_cart, cart})
  end
end
