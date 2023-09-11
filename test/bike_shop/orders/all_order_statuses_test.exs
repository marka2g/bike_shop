defmodule BikeShop.Orders.AllOrderStatusesTest do
  use BikeShop.DataCase

  alias BikeShop.Orders.AllOrderStatuses

  describe "all status order" do
    test "get all status order" do
      assert %AllOrderStatuses{
               all: 0,
               delivered: 0,
               delivering: 0,
               not_started: 0,
               preparing: 0,
               received: 0
             } == AllOrderStatuses.execute()
    end
  end
end
