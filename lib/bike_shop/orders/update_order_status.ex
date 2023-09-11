defmodule BikeShop.Orders.UpdateOrderStatus do
  alias BikeShop.Orders.Events.OrderUpdated
  alias BikeShop.Orders.Order
  alias BikeShop.Repo

  def execute(order_id, old_status, new_status) do
    Order
    |> Repo.get(order_id)
    |> Order.changeset(%{status: new_status})
    |> Repo.update()
    |> OrderUpdated.broadcast_admin_to_orders_updates(old_status)
    |> OrderUpdated.broadcast_update_user_row()
    |> OrderUpdated.broadcast_order_updates()
  end
end
