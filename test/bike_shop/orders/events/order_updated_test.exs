defmodule BikeShop.Orders.Events.OrderUpdatedTest do
  use BikeShop.DataCase
  alias BikeShop.Orders.Events.OrderUpdated

  test "subscribe_admin_to_orders_updates" do
    OrderUpdated.subscribe_admin_to_orders_updates()
    assert {:messages, []} == Process.info(self(), :messages)

    OrderUpdated.broadcast_admin_to_orders_updates({:ok, %{status: :preparing}}, :received)

    assert {:messages, [{:order_updated, %{status: :preparing}, :received}]} ==
             Process.info(self(), :messages)
  end

  test "subscribe_update_user_row" do
    user_id = "123"
    OrderUpdated.subscribe_update_user_row(user_id)
    assert {:messages, []} == Process.info(self(), :messages)

    OrderUpdated.broadcast_update_user_row({:ok, %{status: :preparing, user_id: user_id}})

    assert {:messages, [{:update_order_user_row, %{status: :preparing, user_id: "123"}}]} ==
             Process.info(self(), :messages)
  end

  test "subscribe_to_order_updates" do
    id = "123"
    OrderUpdated.subscribe_to_order_updates(id)
    assert {:messages, []} == Process.info(self(), :messages)

    OrderUpdated.broadcast_order_updates({:ok, %{status: :preparing, id: id}})

    assert {:messages, [{:order_updates, %{status: :preparing, id: "123"}}]} ==
             Process.info(self(), :messages)
  end
end
