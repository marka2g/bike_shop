defmodule BikeShopWeb.ShopLive do
  use BikeShopWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <section class="container py-8 mx-auto" data-role="all-bikes-section">
        <h1 class="mb-8 text-lg font-bold">All Bikes</h1>
        <div
          class="grid justify-between grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4"
          id="bikes-list"
        >
        </div>
      </section>
    </div>
    """
  end
end
