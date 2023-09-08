defmodule BikeShopWeb.ShopLiveTest do
  use BikeShopWeb.ConnCase
  import BikeShop.BikeFixtures
  import Phoenix.LiveViewTest

  test "load all bikes section", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "[data-role=all-bikes-section]")
    assert has_element?(view, "h1", "All Bikes")
    assert has_element?(view, "[data-role=bikes-list]")
  end

  test "load main bikes", %{conn: conn} do
    bike = bike_fixture()

    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "[data-role=bike][data-id=#{bike.id}]")
    assert has_element?(view, "img")
    assert has_element?(view, "h2", bike.name)

    assert has_element?(
             view,
             "span",
             Atom.to_string(bike.type)
           )

    assert has_element?(
             view,
             "span",
             Money.to_string(bike.price)
           )

    assert has_element?(
             view,
             "span",
             "+ add to cart"
           )
  end
end
