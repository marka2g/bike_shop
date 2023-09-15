defmodule BikeShopWeb.Admin.BikeLive.BikeForm do
  use BikeShopWeb, :live_component
  alias BikeShop.Bikes
  import BikeUploadConfig
  import Phoenix.Naming, only: [humanize: 1]

  @impl true
  def update(%{bike: bike} = assigns, socket) do
    changeset = Bikes.change_bike(bike)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)
     |> allow_upload(:image_url, upload_options())}
  end

  @impl true
  def handle_event("validate", %{"bike" => bike_params}, socket) do
    changeset =
      socket.assigns.bike
      |> Bikes.change_bike(bike_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  # coveralls-ignore-start
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end
  # coveralls-ignore-stop

  def handle_event("save", %{"bike" => bike_params}, socket) do
    # coveralls-ignore-start
    {[image_url | _], []} = uploaded_entries(socket, :image_url)
    image_url = get_image_url(image_url)
    bike_params = Map.put(bike_params, "image_url", image_url)
    save(socket, socket.assigns.action, bike_params)
    # coveralls-ignore-stop
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :image_url, ref)}
  end

  defp save(socket, :new, bike_params) do
    # coveralls-ignore-start
    function_result = Bikes.create_bike(bike_params)
    message = "Bike created successfully"
    perform(socket, function_result, message)
    # coveralls-ignore-stop
  end

  defp save(socket, :edit, bike_params) do
    # coveralls-ignore-start
    function_result = Bikes.update_bike(socket.assigns.bike, bike_params)
    message = "Bike updated successfully"
    perform(socket, function_result, message)
    # coveralls-ignore-stop
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  # coveralls-ignore-start
  # defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
  defp notify_parent(msg), do: send(self(), {BikeShopWeb.Admin.BikeLive.Index, msg})
  # coveralls-ignore-stop

  # coveralls-ignore-start
  defp perform(socket, function_result, message) do
    case function_result do
      {:ok, bike} ->
        build_image_url(socket)
        notify_parent({:saved, bike})

        socket =
          socket
          |> put_flash(:info, message)
          |> push_navigate(to: socket.assigns.navigate)
          # |> push_patch(to: socket.assigns.patch)

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
        # {:noreply, assign_form(socket, changeset)}
    end
  end
  # coveralls-ignore-stop

  defp build_image_url(socket) do
    # coveralls-ignore-start
    consume_uploaded_entries(socket, :image_url, &consume_entries/2)
    # coveralls-ignore-stop
  end
end
