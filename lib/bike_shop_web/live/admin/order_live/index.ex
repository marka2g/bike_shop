defmodule BikeShopWeb.Admin.OrderLive.Index do
  use BikeShopWeb, :live_view
  alias __MODULE__.Layer
  alias __MODULE__.SideMenu
  alias BikeShop.Orders

  # coveralls-ignore-start
  def mount(_, _, socket) do
    if connected?(socket) do
      Orders.subscribe_admin_to_orders_updates()
      Orders.subscribe_to_receive_created_orders()
    end

    {:ok, socket}
  end

  def handle_info({:order_updated, %{status: new_status}, old_status}, socket) do
    send_update(Layer, id: old_status)
    send_update(Layer, id: Atom.to_string(new_status))
    send_update(SideMenu, id: "side-menu")
    {:noreply, socket}
  end

  def handle_info({:order_created, %{status: status}}, socket) do
    send_update(Layer, id: Atom.to_string(status))
    send_update(SideMenu, id: "side-menu")
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex h-screen pt-2 overflow-x-auto">
      <.live_component module={SideMenu} id="side-menu" />

      <div class="flex-col flex-1 min-w-0 bg-white">
        <div class="flex-1">
          <main class="flex p-3" data-role="layers">
            <.live_component module={Layer} id="not_started" step="1" />
            <.live_component module={Layer} id="received" step="2" />
            <.live_component module={Layer} id="preparing" step="3" />
            <.live_component module={Layer} id="delivering" step="4" />
            <.live_component module={Layer} id="delivered" step="5" />
          </main>
        </div>
      </div>
    </div>
    """
  end

  # coveralls-ignore-stop
end
