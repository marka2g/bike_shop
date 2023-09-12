defmodule BikeShopWeb.Admin.OrderLive.Index.Layer do
  use BikeShopWeb, :live_component
  import Phoenix.Naming, only: [humanize: 1]
  alias __MODULE__.Card
  alias BikeShop.Orders

  # coveralls-ignore-start
  def update(assigns, socket) do
    orders = Orders.list_orders_by_status(assigns.id)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(cards: orders)}
  end

  # coveralls-ignore-stop

  def render(assigns) do
    # coveralls-ignore-start
    ~H"""
    <div class="flex-shrink-0 p-3 m-2 rounded-md w-80 bg-slate-200">
      <h3 class="text-sm font-medium text-neutral-700">
        <%= @step %>. <%= humanize(@id) %>
      </h3>

      <ul class="mt-2" id={@id} phx-hook="Drag" phx-target={@myself}>
        <.live_component :for={card <- @cards} module={Card} id={card.id} card={card} />
      </ul>
    </div>
    """

    # coveralls-ignore-stop
  end

  # coveralls-ignore-start
  def handle_event(
        "dropped",
        %{
          "new_status" => new_status,
          "old_status" => old_status
        },
        socket
      )
      when new_status == old_status do
    {:noreply, socket}
  end

  def handle_event("dropped", params, socket) do
    %{
      "new_status" => new_status,
      "old_status" => old_status,
      "order_id" => order_id
    } = params

    Orders.update_order_status(order_id, old_status, new_status)
    {:noreply, socket}
  end

  # coveralls-ignore-start
end
