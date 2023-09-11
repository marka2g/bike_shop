defmodule BikeShop.Orders.ListOrdersByStatusTest do
  use BikeShop.DataCase

  import BikeShop.AccountsFixtures
  import BikeShop.OrderFixtures
  import BikeShop.BikeFixtures

  alias BikeShop.Orders.ListOrdersByStatus

  test "return orders using order_id and customer_id" do
    bike = bike_fixture()
    user = user_fixture()
    order_fixtures(bike, user)
    assert 1 == ListOrdersByStatus.execute(:not_started) |> Enum.count()
  end
end
