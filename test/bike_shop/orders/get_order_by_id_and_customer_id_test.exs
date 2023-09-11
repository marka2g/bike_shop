defmodule BikeShop.Orders.GetOrderByIdAndCustomerIdTest do
  use BikeShop.DataCase

  import BikeShop.AccountsFixtures
  import BikeShop.OrderFixtures
  import BikeShop.BikeFixtures

  alias BikeShop.Orders.GetOrderByIdAndCustomerId

  test "return orders using order_id and customer_id" do
    bike = bike_fixture()
    user = user_fixture()
    order = order_fixtures(bike, user)

    assert order.id == GetOrderByIdAndCustomerId.execute(order.id, order.user_id).id
  end
end
