defmodule BikeShop.OrderFixtures do
  alias BikeShop.Orders.Order
  alias BikeShop.Repo

  def order_fixtures(bike, user, attrs \\ %{}) do
    order_attrs =
      attrs
      |> Enum.into(%{
        phone_number: "123",
        address: "123213",
        user_id: user.id,
        items: [%{quantity: 1, bike_id: bike.id}],
        total_quantity: 1,
        total_price: bike.price
      })

    {:ok, order} =
      %Order{}
      |> Order.changeset(order_attrs)
      |> Repo.insert()

    order
  end
end
