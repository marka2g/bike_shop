defmodule BikeShopWeb.Cart.Details.ItemsTest do
  use BikeShopWeb.ConnCase
  import BikeShop.BikeFixtures
  import Phoenix.LiveViewTest

  describe "load page" do
    setup :register_and_log_in_user

    test "load two items component", %{conn: conn} do
      bike = bike_fixture()
      bike_2 = bike_fixture()
      {:ok, view, _html} = live(conn, ~p"/")
      bike_element = build_bike_element(bike.id)
      bike_2_element = build_bike_element(bike_2.id)

      view
      |> add(bike_element, conn)
      |> add(bike_element, conn)
      |> add(bike_2_element, conn)

      {:ok, view, _html} = live(conn, ~p"/cart")

      assert has_element?(view, "##{bike.id}")
      assert has_element?(view, "##{bike_2.id}")

      assert has_element?(view, "##{bike.id}>div>h1", bike.name)
      assert has_element?(view, "##{bike_2.id}>div>h1", bike.name)

      assert has_element?(view, "##{bike.id}>div>span", Atom.to_string(bike.type))
      assert has_element?(view, "##{bike_2.id}>div>span", Atom.to_string(bike.type))

      assert has_element?(view, "[data-role=items][data-id=#{bike.id}]", "2 Item(s)")
      assert has_element?(view, "[data-role=items][data-id=#{bike_2.id}]", "1 Item(s)")

      assert has_element?(
               view,
               "[data-role=price][data-id=#{bike.id}]",
               Money.to_string(bike.price)
             )

      assert has_element?(
               view,
               "[data-role=price][data-id=#{bike_2.id}]",
               Money.to_string(bike_2.price)
             )
    end

    test "decrement 1 item", %{conn: conn} do
      bike = bike_fixture()
      {:ok, view, _html} = live(conn, ~p"/")
      bike_element = build_bike_element(bike.id)

      view
      |> add(bike_element, conn)
      |> add(bike_element, conn)

      {:ok, view, _html} = live(conn, ~p"/cart")

      assert has_element?(view, "[data-role=items][data-id=#{bike.id}]", "2 Item(s)")

      event(view, bike.id, "dec")

      assert has_element?(view, "[data-role=items][data-id=#{bike.id}]", "1 Item(s)")
    end

    test "decrement until remove", %{conn: conn} do
      bike = bike_fixture()
      {:ok, view, _html} = live(conn, ~p"/")

      bike_element = build_bike_element(bike.id)

      view
      |> add(bike_element, conn)
      |> add(bike_element, conn)

      {:ok, view, _html} = live(conn, ~p"/cart")

      assert has_element?(view, "[data-role=items][data-id=#{bike.id}]", "2 Item(s)")

      event(view, bike.id, "dec")
      event(view, bike.id, "dec")

      refute has_element?(view, "[data-role=items][data-id=#{bike.id}]", "2 Item(s)")
    end

    test "increment item", %{conn: conn} do
      bike = bike_fixture()
      {:ok, view, _html} = live(conn, ~p"/")
      bike_element = build_bike_element(bike.id)

      view
      |> add(bike_element, conn)
      |> add(bike_element, conn)

      {:ok, view, _html} = live(conn, ~p"/cart")

      assert has_element?(view, "[data-role=items][data-id=#{bike.id}]", "2 Item(s)")

      event(view, bike.id, "inc")

      assert has_element?(view, "[data-role=items][data-id=#{bike.id}]", "3 Item(s)")
    end

    test "remove item", %{conn: conn} do
      bike = bike_fixture()
      {:ok, view, _html} = live(conn, ~p"/")
      bike_element = build_bike_element(bike.id)

      view
      |> add(bike_element, conn)
      |> add(bike_element, conn)

      {:ok, view, _html} = live(conn, ~p"/cart")

      assert has_element?(view, "[data-role=items][data-id=#{bike.id}]", "2 Item(s)")

      event(view, bike.id, "remove")
      refute has_element?(view, "[data-role=items][data-id=#{bike.id}]", "2 Item(s)")
    end
  end

  defp event(view, bike_id, event) do
    view
    |> element("[data-role=#{event}][data-id=#{bike_id}]")
    |> render_click()
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
