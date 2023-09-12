defmodule BikeShop.Orders do
  alias __MODULE__.Events.{Order, OrderCreated, OrderUpdated}

  alias __MODULE__.{
    Order,
    AllOrderStatuses,
    CreateOrderByCart,
    GetOrderByIdAndCustomerId,
    ListOrdersByStatus,
    ListOrdersByUserId,
    UpdateOrderStatus
  }

  defdelegate subscribe_to_receive_created_orders, to: OrderCreated, as: :subscribe

  defdelegate subscribe_to_order_updates(id), to: OrderUpdated, as: :subscribe_to_order_updates

  defdelegate subscribe_admin_to_orders_updates,
    to: OrderUpdated,
    as: :subscribe_admin_to_orders_updates

  defdelegate subscribe_update_user_row(user_id), to: OrderUpdated, as: :subscribe_update_user_row

  defdelegate all_status_orders, to: AllOrderStatuses, as: :execute
  defdelegate create_order_by_cart(payload), to: CreateOrderByCart, as: :execute

  defdelegate get_order_by_id_and_customer_id(order_id, customer_id),
    to: GetOrderByIdAndCustomerId,
    as: :execute

  defdelegate list_orders_by_status(status), to: ListOrdersByStatus, as: :execute
  defdelegate list_orders_by_user_id(user_id), to: ListOrdersByUserId, as: :execute

  defdelegate update_order_status(order_id, old_status, new_status),
    to: UpdateOrderStatus,
    as: :execute

  def get_status_list do
    Order |> Ecto.Enum.values(:status) |> Enum.with_index()
  end
end
