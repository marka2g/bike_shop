defmodule BikeShopWeb.Admin.BikeLive.BikeForm do
  use BikeShopWeb, :live_component

  alias BikeShop.Bikes

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage bike records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="bike-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:image_url]} type="text" label="Image url" />
        <.input field={@form[:price]} type="number" label="Price" />
        <.input field={@form[:seats]} type="number" label="Seats" />
        <.input
          field={@form[:type]}
          type="select"
          label="Type"
          prompt="Choose a value"
          options={Ecto.Enum.values(BikeShop.Bikes.Bike, :type)}
        />
        <:actions>
          <button
            phx-disable-with="Saving..."
            class="px-3 py-2 text-sm font-semibold bg-green-600 rounded-lg phx-submit-loading:opacity-75 text-green-50 hover:bg-green-700 hover:text-green-50"
          >
            Save Bike
          </button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{bike: bike} = assigns, socket) do
    changeset = Bikes.change_bike(bike)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"bike" => bike_params}, socket) do
    changeset =
      socket.assigns.bike
      |> Bikes.change_bike(bike_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"bike" => bike_params}, socket) do
    save_bike(socket, socket.assigns.action, bike_params)
  end

  defp save_bike(socket, :edit, bike_params) do
    case Bikes.update_bike(socket.assigns.bike, bike_params) do
      {:ok, bike} ->
        notify_parent({:saved, bike})

        {:noreply,
         socket
         |> put_flash(:info, "Bike updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_bike(socket, :new, bike_params) do
    case Bikes.create_bike(bike_params) do
      {:ok, bike} ->
        notify_parent({:saved, bike})

        {:noreply,
         socket
         |> put_flash(:info, "Bike created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
