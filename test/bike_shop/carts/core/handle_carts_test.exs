defmodule BikeShop.Carts.Core.HandleCartsTest do
  use BikeShop.DataCase

  import BikeShop.BikeFixtures
  import BikeShop.Carts.Core.HandleCarts

  alias BikeShop.Carts.Data.Cart

  @init_cart %Cart{
    id: 424_242_424,
    items: [],
    total_price: %Money{amount: 0, currency: :USD},
    total_quantity: 0
  }

  describe "cart" do
    test "create new" do
      assert @init_cart == create(424_242_424)
    end
  end

  describe "add" do
    test "add a new item" do
      bike = bike_fixture()

      cart = add(@init_cart, bike)
      assert 1 == cart.total_quantity
      assert [%{item: bike, quantity: 1}] == cart.items
      assert bike.price == cart.total_price
    end

    test "add a duplicate item" do
      bike = bike_fixture()

      cart = @init_cart |> add(bike) |> add(bike)

      assert 2 == cart.total_quantity
      assert Money.add(bike.price, bike.price) == cart.total_price
      assert [%{item: bike, quantity: 2}] == cart.items
    end
  end

  describe "remove" do
    test "remove an item" do
      bike_1 = bike_fixture()
      bike_2 = bike_fixture()

      cart =
        @init_cart
        |> add(bike_1)
        |> add(bike_1)
        |> add(bike_2)

      assert 3 == cart.total_quantity

      assert bike_1.price
             |> Money.add(bike_1.price)
             |> Money.add(bike_2.price) == cart.total_price

      assert [%{item: bike_1, quantity: 2}, %{item: bike_2, quantity: 1}] == cart.items

      cart = remove(cart, bike_1.id)

      assert 1 == cart.total_quantity
      assert bike_2.price == cart.total_price
      assert [%{item: bike_2, quantity: 1}] == cart.items
    end
  end

  describe "inc" do
    test "inc the same item" do
      bike = bike_fixture()

      cart =
        @init_cart
        |> add(bike)
        |> add(bike)
        |> inc(bike.id)

      assert 3 == cart.total_quantity

      assert bike.price
             |> Money.add(bike.price)
             |> Money.add(bike.price) == cart.total_price
    end
  end

  describe "dec" do
    test "dec the same item" do
      bike = bike_fixture()

      cart =
        @init_cart
        |> add(bike)
        |> add(bike)
        |> dec(bike.id)

      assert 1 == cart.total_quantity

      assert bike.price
             |> Money.add(bike.price)
             |> Money.subtract(bike.price) == cart.total_price
    end

    test "dec down to empty" do
      bike = bike_fixture()

      cart =
        @init_cart
        |> add(bike)
        |> add(bike)
        |> dec(bike.id)
        |> dec(bike.id)

      assert 0 == cart.total_quantity
      ## wtf - fix this
      # IO.inspect(cart.items, label: "cart.items")
      assert [] == cart.items
      assert Money.new(0) == cart.total_price
    end
  end
end
