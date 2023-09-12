defmodule BikeShopWeb.Customer.OrdersLive.Status do
  use BikeShopWeb, :live_view
  import Phoenix.Naming, only: [humanize: 1]
  alias BikeShop.Orders

  def handle_params(%{"id" => id}, _, socket) do
    if connected?(socket) do
      Orders.subscribe_to_order_updates(id)
    end

    current_user = socket.assigns.current_user
    order = Orders.get_order_by_id_and_customer_id(id, current_user.id)
    status_list = Orders.get_status_list()
    {:noreply, assign(socket, order: order, status_list: status_list)}
  end

  def handle_info({:order_updated, order}, socket) do
    {:noreply, assign(socket, order: order)}
  end

  def get_icon(%{status: :not_started} = assigns) do
    ~H"""
    <.icon name="hero-face-frown" class="w-10 h-10 stroke-current" />
    """
  end

  def get_icon(%{status: :received} = assigns) do
    ~H"""
    <.icon name="hero-receipt-percent" class="w-10 h-10 stroke-current" />
    """
  end

  def get_icon(%{status: :preparing} = assigns) do
    ~H"""
    <.icon name="hero-building-storefront" class="w-10 h-10 stroke-current" />
    """
  end

  def get_icon(%{status: :delivering} = assigns) do
    ~H"""
    <.icon name="hero-truck" class="w-10 h-10 stroke-current" />
    """
  end

  def get_icon(%{status: :delivered} = assigns) do
    ~H"""
    <.icon name="hero-face-smile" class="w-10 h-10 stroke-current" />
    """
  end
end
