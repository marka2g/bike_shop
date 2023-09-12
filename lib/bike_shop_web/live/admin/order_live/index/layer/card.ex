defmodule BikeShopWeb.Admin.OrderLive.Index.Layer.Card do
  use BikeShopWeb, :live_component

  # coveralls-ignore-start
  def render(assigns) do
    ~H"""
    <li id={@id} class="block p-5 mb-5 bg-white rounded-md shadow-md hover:cursor-grab draggable">
      <a href="#">
        <div class="mb-2 flex-justify-between hover:cursor-grab">
          <p class="text-xs font-medium text-gray-900 leading snug"><%= @id %></p>
          <.icon name="hero-shopping-cart" class="w-8 h-8 mx-auto text-purple-500 rounded-full" />
        </div>

        <hr />

        <div class="hover:cursor-grab">
          <p class="p-2 text-sm font-medium leading-snug text-gray-900">
            Order Items
          </p>

          <ul>
            <li :for={item <- @card.items} class="flex justify-between mb-1 text-sm">
              <span><%= item.bike.name %></span>
              <span><%= item.bike.price %></span>
            </li>
          </ul>
        </div>

        <hr />

        <div class="hover:cursor-grab">
          <p class="p-2 text-sm font-medium leading-snug text-gray-900">Order description</p>

          <ul class="text-xs">
            <li class="flex justify-between mb-1">
              <span>Total Price:</span>
              <span><%= @card.total_price %></span>
            </li>
            <li class="flex justify-between mb-1">
              <span>Total Quantity:</span>
              <span><%= @card.total_quantity %></span>
            </li>
            <li class="flex justify-between mb-1">
              <span>Customer:</span>
              <span><%= @card.user.email %></span>
            </li>

            <li :if={@card.status == :delivered} class="flex justify-between mb-1">
              <span class="text-purple-500">Delivered at:</span>
              <span class="font-bold"><%= @card.updated_at %></span>
            </li>
          </ul>
        </div>
      </a>
    </li>
    """
  end

  # coveralls-ignore-stop
end
