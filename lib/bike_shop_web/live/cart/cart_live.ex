defmodule BikeShopWeb.CartLive do
  use BikeShopWeb, :live_view
  alias BikeShop.Carts
  alias BikeShopWeb.Cart.Details

  def mount(_params, _session, socket) do
    cart_id = socket.assigns.cart_id
    cart = Carts.get(cart_id)

    {:ok, assign(socket, cart: cart)}
  end

  def handle_info({:update_cart, cart}, socket) do
    {:noreply, assign(socket, cart: cart)}
  end

  def empty_cart(assigns) do
    ~H"""
    <div class="container py-16 mx-auto text-center">
      <h1 class="mb-2 text-3xl font-semibold">
        Your cart is empty
      </h1>
      <p class="mb-12 text-lg text-neutral-500">
        No orders yet. <br /> To order, go to the main page.
      </p>
      <.icon name="hero-shopping-cart" class="w-20 h-20 mx-auto text-purple-500" />
      <a
        href={~p"/"}
        class="inline-block px-6 py-2 mt-12 font-bold text-white bg-purple-500 rounded-full"
      >
        Go back
      </a>
    </div>
    """
  end
end
