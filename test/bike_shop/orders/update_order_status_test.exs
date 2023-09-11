defmodule BikeShop.Orders.UpdateOrderStatusTest do
  use BikeShop.DataCase

  import BikeShop.AccountsFixtures
  import BikeShop.OrderFixtures
  import BikeShop.BikeFixtures

  alias BikeShop.Orders.UpdateOrderStatus

  test "return orders by user id" do
    bike = bike_fixture()
    user = user_fixture()
    order = order_fixtures(bike, user)
    assert {:ok, order_updated} = UpdateOrderStatus.execute(order.id, order.status, :delivered)
    refute order.status == order_updated.status
  end
end
