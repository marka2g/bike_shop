defmodule BikeShopWeb.Customer.OrderLive.IndexTest do
  use BikeShopWeb.ConnCase
  import BikeShop.{BikeFixtures, OrderFixtures}
  import Phoenix.LiveViewTest

  describe "load page" do
    setup :register_and_log_in_user

    test "check order list", %{conn: conn, user: user} do
      bike = bike_fixture()
      order = order_fixtures(bike, user)
      {:ok, view, _html} = live(conn, ~p"/customer/orders")

      assert has_element?(view, "##{order.id}")
    end

    test "send to another layer using the handle_info using pid", %{conn: conn, user: user} do
      bike = bike_fixture()
      order = order_fixtures(bike, user)

      {:ok, view, _html} = live(conn, ~p"/customer/orders")
      assert view |> element("td", "Not started") |> render() =~ "text-purple-600"

      order = Map.put(order, :status, :delivered)
      send(view.pid, {:update_order_user_row, order})

      refute view |> element("td", "Delivered") |> render() =~ "text-purple-600"
    end
  end
end
