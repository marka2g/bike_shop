defmodule BikeShopWeb.Cart.CartLiveTest do
  use BikeShopWeb.ConnCase
  import Phoenix.LiveViewTest

  test "empty cart", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/cart")

    assert has_element?(view, "[data-role=cart]")
    assert has_element?(view, "[data-role=cart]>div>h1", "Your cart is empty")

    assert has_element?(view, "[data-role=cart]>div>a", "Go back")
  end
end
