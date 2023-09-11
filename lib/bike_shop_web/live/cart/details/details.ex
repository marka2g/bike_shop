defmodule BikeShopWeb.Cart.Details do
  use BikeShopWeb, :live_component
  alias __MODULE__.Item

  def handle_event("create_order", _params, socket) do
    {:noreply, socket}

    # case Orders.create_order_by_cart(params) do
    #   {:ok, _order} ->
    #     socket =
    #       socket
    #       |> put_flash(:info, "Order created with Success")
    #       |> push_redirect(to: ~p"/customer/orders")

    #     {:noreply, socket}

    #   {:error, _changeset} ->
    #     socket =
    #       socket
    #       |> put_flash(:error, "Something went wrong, please verify your order")
    #       |> push_redirect(to: ~p"/cart")

    #     {:noreply, socket}
    # end
  end
end
