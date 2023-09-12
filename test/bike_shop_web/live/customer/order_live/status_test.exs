defmodule BikeShopWeb.Customer.OrderLive.StatusTest do
  use BikeShopWeb.ConnCase
  import BikeShop.BikeFixtures
  import BikeShop.OrderFixtures
  import Phoenix.LiveViewTest

  describe "page load" do
    setup :register_and_log_in_user

    test "check list of orders", %{conn: conn, user: user} do
      bike = bike_fixture()
      order = order_fixtures(bike, user)

      {:ok, view, _html} = live(conn, ~p"/customer/orders/#{order.id}")

      assert has_element?(view, "##{order.status}")
      assert has_element?(view, "##{order.status}>div>span", "Not started")
    end

    test "send to another layer with handle_info using the pid", %{conn: conn, user: user} do
      order = order_fixtures(bike_fixture(), user)

      {:ok, view, _html} = live(conn, ~p"/customer/orders/#{order.id}")

      assert view |> element("#not_started") |> render() =~ "text-purple-500"
      refute view |> element("#received") |> render() =~ "text-purple-500"

      order = Map.put(order, :status, :received)
      send(view.pid, {:order_updated, order})

      assert view |> element("#not_started") |> render() =~ "text-purple-500"
      assert view |> element("#received") |> render() =~ "text-purple-500"
    end
  end
end
