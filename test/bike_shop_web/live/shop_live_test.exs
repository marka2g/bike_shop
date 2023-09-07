defmodule BikeShopWeb.ShopLiveTest do
  use BikeShopWeb.ConnCase
  import Phoenix.LiveViewTest

  test "load all bikes section", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "[data-role=all-bikes-section]")
  end
end
