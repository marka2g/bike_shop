defmodule BikeShopWeb.Admin.BikeLive.IndexTest do
  use BikeShopWeb.ConnCase

  import Phoenix.LiveViewTest
  import BikeShop.BikeFixtures

  @update_attrs %{
    name: "some updated name",
    type: :electric,
    description: "some updated description",
    image_url: "some updated image_url",
    price: %Money{amount: 43, currency: :USD},
    seats: 43
  }
  @invalid_attrs %{name: nil, type: nil, description: nil, image_url: nil, price: nil, seats: nil}

  defp create_bike(_) do
    bike = bike_fixture()
    %{bike: bike}
  end

  describe "Index" do
    setup [:create_bike, :register_and_log_in_admin_user]

    test "lists all bikes", %{conn: conn, bike: bike} do
      {:ok, _index_live, html} = live(conn, ~p"/admin/bikes")

      assert html =~ "Listing Bikes"
      assert html =~ bike.name
    end

    test "saves new bike", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/bikes")

      assert index_live |> element("a", "Add Bike +") |> render_click() =~
               "Add Bike +"

      assert_patch(index_live, ~p"/admin/bikes/new")

      assert index_live
             |> form("#bike-form",
               bike: %{
                 name: "some name",
                 type: :electric,
                 description: "some name description",
                 image_url: "some name image_url",
                 price: %Money{amount: 43, currency: :USD},
                 seats: 43
               }
             )
             |> render_submit()

      assert_patch(index_live, ~p"/admin/bikes")

      html = render(index_live)
      assert html =~ "Bike created successfully"
      assert html =~ "some name"
    end

    test "does not save invalid bike", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/bikes")

      index_live
      |> element("a", "Add Bike +")
      |> render_click() =~ "Add Bike +"

      assert_patch(index_live, ~p"/admin/bikes/new")

      result =
        index_live
        |> form("#bike-form", %{bike: @invalid_attrs})
        |> render_submit()

      assert result =~ "New Bike"
      assert result =~ "client-error"
    end

    test "does not update invalid bike", %{conn: conn, bike: bike} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/bikes")

      assert index_live |> element("#bikes-#{bike.id} a", "Edit") |> render_click() =~
               "Edit Bike"

      assert_patch(index_live, ~p"/admin/bikes/#{bike}/edit")

      result =
        index_live
        |> form("#bike-form", %{bike: @invalid_attrs})
        |> render_submit()

      assert result =~ "Edit Bike"
      assert result =~ "client-error"
    end

    test "updates bike in listing", %{conn: conn, bike: bike} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/bikes")

      assert index_live |> element("#bikes-#{bike.id} a", "Edit") |> render_click() =~
               "Edit Bike"

      assert_patch(index_live, ~p"/admin/bikes/#{bike}/edit")

      assert index_live
             |> form("#bike-form", bike: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bike-form", bike: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/admin/bikes")

      html = render(index_live)
      assert html =~ "Bike updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes bike in listing", %{conn: conn, bike: bike} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/bikes")

      assert index_live |> element("#bikes-#{bike.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bikes-#{bike.id}")
    end
  end

  describe "Show" do
    setup [:create_bike, :register_and_log_in_admin_user]

    test "displays bike", %{conn: conn, bike: bike} do
      {:ok, _show_live, html} = live(conn, ~p"/admin/bikes/#{bike}")

      assert html =~ "Show Bike"
      assert html =~ bike.name
    end

    test "updates bike within modal", %{conn: conn, bike: bike} do
      {:ok, show_live, _html} = live(conn, ~p"/admin/bikes/#{bike}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bike"

      assert_patch(show_live, ~p"/admin/bikes/#{bike}/show/edit")

      assert show_live
             |> form("#bike-form", bike: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#bike-form", bike: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/admin/bikes/#{bike}")

      html = render(show_live)
      assert html =~ "Bike updated successfully"
      assert html =~ "some updated name"
    end
  end
end
