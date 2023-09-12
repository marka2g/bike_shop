defmodule BikeShop.Carts do
  @name :cart_session_server
  def create(cart_id), do: GenServer.cast(@name, {:create, cart_id})
  def add(cart_id, bike), do: GenServer.cast(@name, {:add, cart_id, bike})
  def get(cart_id), do: GenServer.call(@name, {:get, cart_id})
  def inc(cart_id, bike_id), do: GenServer.call(@name, {:inc, cart_id, bike_id})
  def dec(cart_id, bike_id), do: GenServer.call(@name, {:dec, cart_id, bike_id})
  def remove(cart_id, bike_id), do: GenServer.call(@name, {:remove, cart_id, bike_id})
  def delete(cart_id), do: GenServer.cast(@name, {:delete, cart_id})
end
