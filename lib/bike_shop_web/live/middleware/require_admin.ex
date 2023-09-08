defmodule BikeShopWeb.RequireAdmin do
  use BikeShopWeb, :html

  def on_mount(_default, _params, _session, socket) do
    current_user = socket.assigns.current_user

    if current_user.role == :admin do
      {:cont, socket}
    else
      {:halt,
       socket
       |> Phoenix.LiveView.put_flash(:error, "You need to be an Admin to access this page.")
       # coveralls-ignore-start
       |> Phoenix.LiveView.redirect(to: ~p"/")}

      # coveralls-ignore-stop
    end
  end
end
