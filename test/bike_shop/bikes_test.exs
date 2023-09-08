defmodule BikeShop.BikesTest do
  use BikeShop.DataCase

  alias BikeShop.Bikes

  describe "bikes" do
    alias BikeShop.Bikes.Bike

    import BikeShop.BikeFixtures

    @invalid_attrs %{
      name: nil,
      type: nil,
      description: nil,
      image_url: nil,
      price: nil,
      seats: nil
    }

    test "list_bikes/0 returns all bikes" do
      bike = bike_fixture()
      assert Bikes.list_bikes() == [bike]
    end

    test "get_bike!/1 returns the bike with given id" do
      bike = bike_fixture()
      assert Bikes.get_bike!(bike.id) == bike
    end

    test "list_suggest_names/1" do
      bike = bike_fixture(name: "Bike 1")
      assert Bikes.list_suggest_names("Bike 1") == [bike.name]
    end

    test "create_bike/1 with valid data creates a bike" do
      valid_attrs = %{
        name: "some name",
        type: :pedal,
        description: "some description",
        image_url: "some image_url",
        price: 42,
        seats: 42
      }

      assert {:ok, %Bike{} = bike} = Bikes.create_bike(valid_attrs)
      assert bike.name == "some name"
      assert bike.type == :pedal
      assert bike.description == "some description"
      assert bike.image_url == "some image_url"
      assert bike.price == %Money{amount: 42, currency: :USD}
      assert bike.seats == 42
    end

    test "create_bike/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bikes.create_bike(@invalid_attrs)
    end

    test "update_bike/2 with valid data updates the bike" do
      bike = bike_fixture()

      update_attrs = %{
        name: "some updated name",
        type: :electric,
        description: "some updated description",
        image_url: "some updated image_url",
        price: %Money{amount: 43, currency: :USD},
        seats: 43
      }

      assert {:ok, %Bike{} = bike} = Bikes.update_bike(bike, update_attrs)
      assert bike.name == "some updated name"
      assert bike.type == :electric
      assert bike.description == "some updated description"
      assert bike.image_url == "some updated image_url"
      assert bike.price == %Money{amount: 43, currency: :USD}
      assert bike.seats == 43
    end

    test "update_bike/2 with invalid data returns error changeset" do
      bike = bike_fixture()
      assert {:error, %Ecto.Changeset{}} = Bikes.update_bike(bike, @invalid_attrs)
      assert bike == Bikes.get_bike!(bike.id)
    end

    test "delete_bike/1 deletes the bike" do
      bike = bike_fixture()
      assert {:ok, %Bike{}} = Bikes.delete_bike(bike)
      assert_raise Ecto.NoResultsError, fn -> Bikes.get_bike!(bike.id) end
    end

    test "change_bike/1 returns a bike changeset" do
      bike = bike_fixture()
      assert %Ecto.Changeset{} = Bikes.change_bike(bike)
    end
  end
end
