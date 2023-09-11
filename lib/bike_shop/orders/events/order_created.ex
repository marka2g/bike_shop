defmodule BikeShop.Orders.Events.OrderCreated do
  alias Phoenix.PubSub
  @pubsub BikeShop.PubSub
  @topic "order_created"

  def subscribe, do: PubSub.subscribe(@pubsub, @topic)

  def broadcast({:error, _} = err), do: err

  def broadcast({:ok, order} = result) do
    PubSub.broadcast(@pubsub, @topic, {:order_created, order})
    result
  end
end
