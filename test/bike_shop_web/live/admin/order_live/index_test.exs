defmodule BikeShopWeb.Admin.OrderLive.IndexTest do
  use BikeShopWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "index" do
    setup [:register_and_log_in_admin_user]

    test "render main elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/orders")

      assert has_element?(view, "[data-role=layers]")
      assert has_element?(view, "#side-menu")
      assert has_element?(view, "#not_started")
      assert has_element?(view, "#received")
      assert has_element?(view, "#preparing")
      assert has_element?(view, "#delivering")
      assert has_element?(view, "#delivered")
    end
  end
end
