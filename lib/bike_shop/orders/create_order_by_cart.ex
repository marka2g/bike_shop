defmodule BikeShop.Orders.CreateOrderByCart do
  alias BikeShop.Carts
  alias BikeShop.Orders.Events.OrderCreated
  alias BikeShop.Orders.Order
  alias BikeShop.Repo

  def execute(%{"current_user" => current_user} = payload) do
    current_user
    |> Carts.get()
    |> convert_cart_to_payload_item()
    |> create_order_payload(payload)
    |> Repo.insert()
    |> OrderCreated.broadcast()
    |> remove_cache()
  end

  defp convert_cart_to_payload_item(%{items: items} = cart) do
    payload_items = Enum.map(items, &%{quantity: &1.quantity, product_id: &1.item.id})
    {cart, payload_items}
  end

  defp create_order_payload({cart, items}, payload) do
    attrs = %{
      phone_number: payload["phone_number"],
      address: payload["address"],
      user_id: payload["current_user"],
      items: items,
      total_quantity: cart.total_quantity,
      total_price: cart.total_price
    }

    Order.changeset(%Order{}, attrs)
  end

  defp remove_cache({:error, _} = err), do: err

  defp remove_cache({:ok, order} = result) do
    Carts.delete(order.user_id)
    result
  end
end
