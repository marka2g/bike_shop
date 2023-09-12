defmodule BikeShopWeb.Admin.OrderLive.Index.SideMenu do
  use BikeShopWeb, :live_component
  alias BikeShop.Orders

  # coveralls-ignore-start
  def update(assigns, socket) do
    statuses = Orders.all_status_orders() |> Map.from_struct()

    socket =
      socket
      |> assign(assigns)
      |> assign(statuses)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div id={@id} class="w-64 px-8 py-4 overflow-auto border-r bg-slate-50">
      <nav class="mt-8">
        <h2 class="mb-2 text-xs font-semibold tracking-wide uppercase text-neutral-600">Orders</h2>

        <div class="mt-2 -mx-3">
          <a
            href="#"
            class="flex items-center justify-between px-3 py-2 rounded-lg shadow-md bg-slate-200"
          >
            <span class="text-sm font-medium text-neutral-900">All</span>
            <span class="text-sm font-semibold text-neutral-700"><%= @all %></span>
          </a>

          <a
            href="#"
            class="flex items-center justify-between px-3 py-2 mt-2 rounded-lg shadow-md bg-slate-200"
          >
            <span class="text-sm font-medium text-neutral-900">Not Started</span>
            <span class="text-sm font-semibold text-neutral-700"><%= @not_started %></span>
          </a>

          <a
            href="#"
            class="flex items-center justify-between px-3 py-2 mt-2 rounded-lg shadow-md bg-slate-200"
          >
            <span class="text-sm font-medium text-neutral-900">Received</span>
            <span class="text-sm font-semibold text-neutral-700"><%= @received %></span>
          </a>

          <a
            href="#"
            class="flex items-center justify-between px-3 py-2 mt-2 rounded-lg shadow-md bg-slate-200"
          >
            <span class="text-sm font-medium text-neutral-900">Preparing</span>
            <span class="text-sm font-semibold text-neutral-700"><%= @preparing %></span>
          </a>

          <a
            href="#"
            class="flex items-center justify-between px-3 py-2 mt-2 rounded-lg shadow-md bg-slate-200"
          >
            <span class="text-sm font-medium text-neutral-900">Delivering</span>
            <span class="text-sm font-semibold text-neutral-700"><%= @delivering %></span>
          </a>

          <a
            href="#"
            class="flex items-center justify-between px-3 py-2 mt-2 rounded-lg shadow-md bg-slate-200"
          >
            <span class="text-sm font-medium text-neutral-900">Delivered</span>
            <span class="text-sm font-semibold text-neutral-700"><%= @delivered %></span>
          </a>
        </div>
      </nav>
    </div>
    """
  end

  # coveralls-ignore-stop
end
