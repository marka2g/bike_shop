defmodule BikeShopWeb.Admin.BikeLive.ShowTest do
  use BikeShopWeb.ConnCase
  import BikeShop.BikeFixtures
  import Phoenix.LiveViewTest

  def create_bike(_) do
    bike = bike_fixture()
    %{bike: bike}
  end

  describe "Show" do
    setup [:create_bike, :register_and_log_in_admin_user]

    test "display bike", %{conn: conn, bike: bike} do
      {:ok, view, _html} = live(conn, ~p"/admin/bikes/#{bike}")
      assert view |> has_element?("div>dt", "Name")
      assert view |> has_element?("div>dd", bike.name)
    end

    test "has Edit Bike button", %{conn: conn, bike: bike} do
      {:ok, _show_live, html} = live(conn, ~p"/admin/bikes/#{bike}/show/edit")
      assert html =~ "Edit Bike"
    end
  end
end
