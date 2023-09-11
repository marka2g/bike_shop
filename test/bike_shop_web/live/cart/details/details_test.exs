defmodule BikeShopWeb.Cart.DetailsTest do
  use BikeShopWeb.ConnCase
  import BikeShop.BikeFixtures
  import Phoenix.LiveViewTest

  describe "load shop page" do
    setup :register_and_log_in_user

    test "creates successful order", %{conn: conn} do
      bike = bike_fixture()
      bike_2 = bike_fixture()
      {:ok, view, _html} = live(conn, ~p"/")
      bike_element = build_bike_element(bike.id)
      bike_2_element = build_bike_element(bike_2.id)

      view
      |> add(bike_element, conn)
      |> add(bike_element, conn)
      |> add(bike_2_element, conn)

      {:ok, _view, _html} = live(conn, ~p"/cart")

      # {:ok, _view, html} =
      #   view
      #   |> form("#confirm-order-form", %{
      #     "phone_number" => "11231312312",
      #     "address" => "Abc street"
      #   })
      #   |> render_submit()
      #   |> follow_redirect(conn, ~p"/customer/orders")

      # assert html =~ "hi"
    end

    test "error trying to create an order", %{conn: conn} do
      bike = bike_fixture()
      bike_2 = bike_fixture()
      {:ok, view, _html} = live(conn, ~p"/")
      bike_element = build_bike_element(bike.id)
      bike_2_element = build_bike_element(bike_2.id)

      view
      |> add(bike_element, conn)
      |> add(bike_element, conn)
      |> add(bike_2_element, conn)

      {:ok, _view, _html} = live(conn, ~p"/cart")

      # {:ok, _view, _html} =
      #   view
      #   |> form("#confirm-order-form", %{})
      #   |> render_submit()
      #   |> follow_redirect(conn, ~p"/cart")
    end
  end

  defp build_bike_element(bike_id) do
    "[data-id=#{bike_id}]>div>div>button"
  end

  defp add(view, bike_element, conn) do
    {:ok, view, _html} =
      view
      |> element(bike_element)
      |> render_click()
      |> follow_redirect(conn, ~p"/")

    view
  end
end
