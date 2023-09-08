defmodule BikeShopWeb.Admin.BikeLive.ShowTest do
  use BikeShopWeb.ConnCase
  import BikeShop.BikeFixtures
  import Phoenix.LiveViewTest

  describe "Show" do
    setup [:create_bike, :register_and_log_in_admin_user]

    test "display bike", %{conn: conn, bike: bike} do
      {:ok, view, _html} = live(conn, ~p"/admin/bikes/#{bike}")
      assert has_element?(view, "div>dt", "Name")
      assert has_element?(view, "div>dd", bike.name)
    end
  end

  def create_bike(_) do
    bike = bike_fixture()
    %{bike: bike}
  end
end
