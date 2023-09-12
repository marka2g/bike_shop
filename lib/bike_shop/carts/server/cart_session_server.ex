defmodule BikeShop.Carts.Server.CartSessionServer do
  use GenServer
  import BikeShop.Carts.Core.HandleCarts

  @name :cart_session_server

  def start_link(_) do
    GenServer.start_link(__MODULE__, @name, name: @name)
  end

  def init(name) do
    :ets.new(name, [:set, :public, :named_table])
    {:ok, name}
  end

  def handle_call({:get, cart_id}, _from, name) do
    {:ok, cart} = find_cart(name, cart_id)
    {:reply, cart, name}
  end

  def handle_call({:inc, cart_id, bike_id}, _from, name) do
    {:ok, cart} = find_cart(name, cart_id)
    cart = inc(cart, bike_id)
    :ets.insert(name, {cart_id, cart})
    {:reply, cart, name}
  end

  def handle_call({:dec, cart_id, bike_id}, _from, name) do
    {:ok, cart} = find_cart(name, cart_id)
    cart = dec(cart, bike_id)
    :ets.insert(name, {cart_id, cart})
    {:reply, cart, name}
  end

  def handle_call({:remove, cart_id, bike_id}, _from, name) do
    {:ok, cart} = find_cart(name, cart_id)
    cart = remove(cart, bike_id)
    :ets.insert(name, {cart_id, cart})
    {:reply, cart, name}
  end

  def handle_cast({:create, cart_id}, name) do
    case find_cart(name, cart_id) do
      {:error, []} -> :ets.insert(name, {cart_id, create(cart_id)})
      {:ok, _} -> :ok
    end

    {:noreply, name}
  end

  def handle_cast({:add, cart_id, bike}, name) do
    {:ok, cart} = find_cart(name, cart_id)
    cart = add(cart, bike)
    :ets.insert(name, {cart_id, cart})
    {:noreply, name}
  end

  def handle_cast({:delete, cart_id}, name) do
    :ets.delete(name, cart_id)
    {:noreply, name}
  end

  defp find_cart(name, cart_id) do
    case :ets.lookup(name, cart_id) do
      [] -> {:error, []}
      [{_cart_id, value}] -> {:ok, value}
    end
  end
end
