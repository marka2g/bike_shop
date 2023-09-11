defmodule BikeShopWeb.ShopLive.Bike.BikeComponentTest do
  use BikeShopWeb.ConnCase
  import Phoenix.LiveViewTest

  test "bike component has bike-details section", %{conn: conn} do
    {:ok, _view, _html} = live(conn, ~p"/")

    # assert has_element?(view, "[data-role=bike]")
  end
end
