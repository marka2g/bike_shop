defmodule BikeShopWeb.Admin.BikeLive.Index do
  use BikeShopWeb, :live_view

  alias BikeShop.Bikes
  alias BikeShop.Bikes.Bike
  alias BikeShopWeb.Admin.BikeLive.BikeForm

  def mount(_params, _session, socket) do
    {:ok, stream(socket, :bikes, Bikes.list_bikes())}
  end

  def handle_params(params, _url, socket) do
    live_action = socket.assigns.live_action
    bike_name = params["name"] || ""

    bikes = Bikes.list_bikes(name: bike_name)
    options = %{name: bike_name}

    assigns = [options: options, bikes: bikes, loading: false, names: []]

    socket =
      socket
      |> apply_action(live_action, params)
      |> assign(assigns)

    {:noreply, socket}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    # coveralls-ignore-start
    socket
    |> assign(:page_title, "Edit Bike")
    |> assign(:bike, Bikes.get_bike!(id))
    # coveralls-ignore-stop
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bike")
    |> assign(:bike, %Bike{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bikes")
    |> assign(:bike, nil)
  end

  # coveralls-ignore-start
  def handle_info({BikeForm, {:saved, bike}}, socket) do
    {:noreply, stream_insert(socket, :bikes, bike)}
  end
  # coveralls-ignore-stop

  def handle_info({:list_bike, name}, socket) do
    params = [name: name]
    {:noreply, do_filter(socket, params)}
  end

  def do_filter(socket, params) do
    params
    |> Bikes.list_bikes()
    |> return_response(socket, params)
  end

  defp return_response([], socket, params) do
    assigns = [loading: false, bikes: []]

    socket
    |> assign(assigns)
    |> update(:options, &Map.put(&1, :name, params[:name]))
    |> put_flash(:error, "There is no bike with: \"#{params[:name]}\"")
  end

  defp return_response(bikes, socket, _params) do
    stream(socket, :bikes, bikes, reset: true)
  end

  def handle_event("delete", %{"id" => id}, socket) do
    bike = Bikes.get_bike!(id)
    {:ok, _} = Bikes.delete_bike(bike)

    {:noreply, stream_delete(socket, :bikes, bike)}
  end

  def handle_event("filter_by_name", %{"name" => name}, socket) do
    socket = apply_filters(socket, name)
    {:noreply, socket}
  end

  def handle_event("suggest", %{"name" => name}, socket) do
    names = Bikes.list_suggest_names(name)
    {:noreply, assign(socket, names: names)}
  end

  defp apply_filters(socket, name) do
    assigns = [bikes: [], loading: true]
    send(self(), {:list_bike, name})

    socket
    |> assign(assigns)
    |> update(:options, &Map.put(&1, :name, name))
  end

  def name_search(assigns) do
    ~H"""
    <form phx-submit="filter_by_name" phx-change="suggest" class="mr-4">
      <div class="relative">
        <span class="absolute inset-y-0 left-0 flex items-center pl-2">
          <.icon name="hero-magnifying-glass" class="w-6 h-6 stroke-current" />
        </span>
        <input
          type="text"
          autocomplete="off"
          list="names"
          name="name"
          value={@name}
          placeholder="Search by Name"
          class="py-4 pl-10 pr-4 text-sm leading-tight border rounded-md text-neutral-800 placeholder-neutral-500 border-neutral-300"
        />
      </div>
    </form>

    <datalist id="names">
      <option :for={name <- @names}><%= name %></option>
    </datalist>
    """
  end
end
