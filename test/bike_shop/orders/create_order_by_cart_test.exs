defmodule BikeShop.Orders.CreateOrderByCartTest do
  use BikeShop.DataCase

  alias BikeShop.Carts
  alias BikeShop.Orders.CreateOrderByCart

  import BikeShop.AccountsFixtures
  import BikeShop.BikeFixtures

  describe "create_order/1" do
    test "success" do
      bike = bike_fixture()
      user = user_fixture()

      Carts.create(user.id)
      Carts.add(user.id, bike)

      assert 1 == Carts.get(user.id).total_quantity

      payload = %{
        "address" => "123",
        "current_user" => user.id,
        "phone_number" => "123"
      }

      {:ok, result} = CreateOrderByCart.execute(payload)

      assert 1 == result.total_quantity
    end

    test "error" do
      user = user_fixture()
      Carts.create(user.id)

      payload = %{
        "address" => "123",
        "current_user" => user.id,
        "phone_number" => "123"
      }

      {:error, changeset} = CreateOrderByCart.execute(payload)

      assert "must be greater than 0" in errors_on(changeset).total_quantity
    end
  end
end
