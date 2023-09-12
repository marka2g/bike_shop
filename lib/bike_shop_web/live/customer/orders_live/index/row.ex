defmodule BikeShopWeb.Customer.OrdersLive.Index.Row do
  use BikeShopWeb, :live_component
  import Phoenix.Naming, only: [humanize: 1]

  def update(%{order_updated: order}, socket) do
    {:ok, assign(socket, order: order)}
  end

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  def render(assigns) do
    ~H"""
    <tr id={@id}>
      <td class="px-4 py-2 border">
        <.link href={~p"/customer/orders/#{@order.id}"}><%= @order.id %></.link>
      </td>
      <td class="px-4 py-2 border">
        <%= @order.address %> - <%= @order.phone_number %>
      </td>
      <td class={[(@order.status != :delivered && "text-purple-600") || "", "border px-4 py-2"]}>
        <%= humanize(@order.status) %>
      </td>
      <td class="px-4 py-2 border">
        <%= @order.updated_at |> NaiveDateTime.to_string() %>
      </td>
    </tr>
    """
  end
end
