defmodule BikeShop.Orders.ListOrdersByUserIdTest do
  use BikeShop.DataCase

  import BikeShop.AccountsFixtures
  import BikeShop.OrderFixtures
  import BikeShop.BikeFixtures

  alias BikeShop.Orders.ListOrdersByUserId

  test "return orders by user id" do
    bike = bike_fixture()
    user = user_fixture()
    order_fixtures(bike, user)
    assert 1 == ListOrdersByUserId.execute(user.id) |> Enum.count()
  end
end
