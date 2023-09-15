defmodule BikeShopWeb.Admin.BikeLive.IndexTest do
  use BikeShopWeb.ConnCase, async: false

  import Phoenix.LiveViewTest
  import BikeShop.BikeFixtures

  defp create_bike(_) do
    bike = bike_fixture()
    %{bike: bike}
  end

  describe "index" do
    setup [:create_bike, :register_and_log_in_admin_user]

    test "lists all bikes", %{conn: conn, bike: bike} do
      {:ok, _index_live, html} = live(conn, ~p"/admin/bikes")

      assert html =~ "Listing Bikes"
      assert html =~ bike.name
    end

    test "deletes bike in listing", %{conn: conn, bike: bike} do
      {:ok, index_view, _html} = live(conn, ~p"/admin/bikes")

      assert index_view |> element("#bikes-#{bike.id} a", "Delete") |> render_click()
      refute has_element?(index_view, "#bikes-#{bike.id}")
    end
  end

  describe "index - Add Bike button (with uploads)" do
    setup [:create_bike, :register_and_log_in_admin_user]

    test "error displayed when not including bike name", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/bikes")

      assert view |> element("header>div>div>a", "Add Bike +") |> render_click()

      assert_patch(view, ~p"/admin/bikes/new")

      assert view |> has_element?("#bike-modal")

      assert view
             |> form("#bike-form", %{bike: %{name: nil, description: "some desc"}})
             |> render_change() =~ "be blank"
    end

    test "error displayed when not including bike description", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/bikes")
      assert view |> element("header>div>div>a", "Add Bike +") |> render_click()

      html =
        view
        |> form("#bike-form", %{bike: %{name: "some name", description: nil}})
        |> render_change()

      assert html =~ "can&#39;t be blank"
      assert has_element?(view, "p", "can't be blank")
    end

    test "preview of bike to be uploaded is displayed", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/bikes")
      assert view |> element("header>div>div>a", "Add Bike +") |> render_click()

      assert_patch(view, ~p"/admin/bikes/new")

      view
      |> upload("/images/bikes/thor.jpg")

      assert has_element?(view, "[data-role='image-preview']")
    end

    test "user can cancel upload", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/bikes")
      assert view |> element("header>div>div>a", "Add Bike +") |> render_click()

      assert_patch(view, ~p"/admin/bikes/new")

      view
      |> upload("/images/bikes/thor.jpg")
      |> cancel_upload()

      refute has_element?(view, "[data-role='image-preview']")
    end

    test "error displayed when uploading too many files", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/bikes")
      assert view |> element("header>div>div>a", "Add Bike +") |> render_click()

      assert_patch(view, ~p"/admin/bikes/new")

      assert view |> has_element?("#bike-modal")

      filename = "/images/bikes/thor.jpg"
      upload = view |> upload_file_input(filename)
      assert render_upload(upload, filename, 100) =~ "100%"

      upload2 = view |> upload_file_input(filename)

      rendered_upload = render_upload(upload2, "/images/bikes/thor.jpg", 100)
      assert {:error, [[_, :too_many_files]]} = rendered_upload
    end

    # fail
    test "user can submit upload", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/bikes")
      assert view |> element("header>div>div>a", "Add Bike +") |> render_click()

      assert_patch(view, ~p"/admin/bikes/new")

      assert view |> has_element?("#bike-modal")

      filename = "/images/bikes/thor.jpg"
      upload = view |> upload_file_input(filename)

      assert render_upload(upload, filename, 100) =~ "100%"
    end
  end

  describe "Show" do
    setup [:create_bike, :register_and_log_in_admin_user]

    test "displays bike", %{conn: conn, bike: bike} do
      {:ok, _show_live, html} = live(conn, ~p"/admin/bikes/#{bike}")

      assert html =~ "Show Bike"
      assert html =~ bike.name
    end
  end

  # defp create_bike_form(view, name) do
  #   view
  #   |> form("#bike-form", %{bike: %{name: name, description: "some description"}})
  #   |> render_submit()
  # end

  defp cancel_upload(view) do
    view
    |> element("[data-role='cancel-upload']")
    |> render_click()
  end

  defp upload(view, filename) do
    upload_file_input(view, filename) |> render_upload(filename)

    view
    |> form("#bike-form")
    |> render_change()

    view
  end

  defp upload_file_input(view, filename) do
    view
    |> file_input("#bike-form", :image_url, [
      %{
        name: filename,
        content: File.read!("test/support/#{filename}"),
        type: "image/jpg"
      }
    ])
  end
end
