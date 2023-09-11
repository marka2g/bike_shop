defmodule BikeShop.Orders.Events.OrderUpdated do
  alias Phoenix.PubSub
  @pubsub BikeShop.PubSub
  @order_updates "order_updates"
  @admin_orders_updates "admin_orders_updates"
  @update_user_row "update_user_row"

  def subscribe_to_order_updates(id), do: PubSub.subscribe(@pubsub, @order_updates <> ":#{id}")

  def broadcast_order_updates({:ok, order} = result) do
    PubSub.broadcast(@pubsub, @order_updates <> ":#{order.id}", {:order_updates, order})
    result
  end

  def broadcast_order_updates({:error, _} = err, _), do: err

  def subscribe_admin_to_orders_updates, do: PubSub.subscribe(@pubsub, @admin_orders_updates)

  def broadcast_admin_to_orders_updates({:ok, order} = result, old_status) do
    PubSub.broadcast(@pubsub, @admin_orders_updates, {:order_updated, order, old_status})
    result
  end

  def broadcast_admin_to_orders_updates({:error, _} = err, _), do: err

  def subscribe_update_user_row(user_id),
    do: PubSub.subscribe(@pubsub, @update_user_row <> ":#{user_id}")

  def broadcast_update_user_row({:ok, order} = result) do
    PubSub.broadcast(
      @pubsub,
      @update_user_row <> ":#{order.user_id}",
      {:update_order_user_row, order}
    )

    result
  end

  def broadcast_update_user_row({:error, _} = err, _), do: err
end
