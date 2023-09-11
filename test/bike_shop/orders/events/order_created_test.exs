defmodule BikeShop.Orders.Events.OrderCreatedTest do
  use BikeShop.DataCase
  alias BikeShop.Orders.Events.OrderCreated

  test "subscribe to receive new orders" do
    OrderCreated.subscribe()
    assert {:messages, []} == Process.info(self(), :messages)
  end

  test "receive broadcast message" do
    OrderCreated.subscribe()
    assert {:messages, []} == Process.info(self(), :messages)

    OrderCreated.broadcast({:ok, %{id: 123}})

    assert {:messages, [{:order_created, order}]} = Process.info(self(), :messages)
    assert order.id == 123
  end

  test "error broadcast message" do
    OrderCreated.subscribe()
    assert {:messages, []} == Process.info(self(), :messages)

    OrderCreated.broadcast({:error, %{id: 123}})

    assert {:messages, []} = Process.info(self(), :messages)
  end
end
