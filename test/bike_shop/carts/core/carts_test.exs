defmodule BikeShop.CartsTest do
  use BikeShop.DataCase
  import BikeShop.Carts
  import BikeShop.BikeFixtures

  # describe "get" do
  # end
  describe "create" do
    test "create session" do
      assert create(424_242) == :ok
    end

    test "create duplicate session" do
      assert create(424_242) == :ok
      assert create(424_242) == :ok
    end
  end

  describe "add" do
    test "add a bike" do
      cart_id = 2_121_212_121
      create(cart_id)
      bike = bike_fixture()

      assert :ok == add(cart_id, bike)
      assert 1 == get(cart_id).total_quantity
    end

    test "add the same bike" do
      cart_id = 2_221_112_121
      create(cart_id)
      bike = bike_fixture()

      assert :ok == add(cart_id, bike)
      assert 2 == inc(cart_id, bike.id).total_quantity
    end
  end

  describe "dec" do
    test "dec bike" do
      cart_id = Ecto.UUID.generate()
      create(cart_id)
      bike = bike_fixture()

      assert :ok == add(cart_id, bike)
      assert 0 == dec(cart_id, bike.id).total_quantity
    end
  end

  describe "remove" do
    test "remove bike" do
      cart_id = Ecto.UUID.generate()
      create(cart_id)
      bike_1 = bike_fixture()
      bike_2 = bike_fixture()

      assert :ok == add(cart_id, bike_1)
      assert :ok == add(cart_id, bike_2)

      assert 2 == get(cart_id).total_quantity
      assert 1 == remove(cart_id, bike_1.id).total_quantity
    end
  end

  describe "delete" do
    cart_id = Ecto.UUID.generate()
    create(cart_id)
    assert :ok == delete(cart_id)
  end
end
