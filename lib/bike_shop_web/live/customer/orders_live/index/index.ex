defmodule BikeShopWeb.Customer.OrdersLive.Index do
  use BikeShopWeb, :live_view
  alias __MODULE__.Row
  alias BikeShop.Orders

  def mount(_, _, socket) do
    current_user = socket.assigns.current_user
    if connected?(socket), do: Orders.subscribe_update_user_row(current_user.id)

    orders = Orders.list_orders_by_user_id(current_user.id)
    socket = socket |> assign(orders: orders)
    {:ok, socket}
  end

  def handle_info({:update_order_user_row, order}, socket) do
    send_update(Row, id: order.id, order_updated: order)
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="container pt-12 mx-auto">
      <table class="w-full bg-white table-auto">
        <thead>
          <th class="px-4 py-2 text-left">Orders</th>
          <th class="px-4 py-2 text-left">Address</th>
          <th class="px-4 py-2 text-left">Status</th>
          <th class="px-4 py-2 text-left">Time</th>
        </thead>

        <tbody>
          <.live_component :for={order <- @orders} module={Row} id={order.id} order={order} />
        </tbody>
      </table>
    </div>
    """
  end
end
