defmodule BikeShopWeb.TopNavComponent do
  use BikeShopWeb, :html

  def menu(assigns) do
    ~H"""
    <nav class="flex items-center justify-between py-2 border-b border-neutral-200">
      <a href={~p"/"} id="logo">
        <img src="/images/logo.png" alt="" class="h-20 w-26" />
      </a>
      <div class="flex text-2xl text-neutral-600">
        Bikes Of Burning Man
      </div>
      <ul class="flex items-center">
        <a
          class="bg-neutral-100 hover:bg-neutral-200 rounded-lg font-bold transition flex items-center text-neutral-700 leading-6 py-2 px-2 -my-1 -mx-1.5"
          href="https://github.com/marka2g/bike_shop"
          target="_blank"
        >
          <svg viewBox="0 0 24 24" aria-hidden="true" class="w-12 h-12">
            <path
              fill-rule="evenodd"
              clip-rule="evenodd"
              d="M12 2C6.477 2 2 6.463 2 11.97c0 4.404 2.865 8.14 6.839 9.458.5.092.682-.216.682-.48 0-.236-.008-.864-.013-1.695-2.782.602-3.369-1.337-3.369-1.337-.454-1.151-1.11-1.458-1.11-1.458-.908-.618.069-.606.069-.606 1.003.07 1.531 1.027 1.531 1.027.892 1.524 2.341 1.084 2.91.828.092-.643.35-1.083.636-1.332-2.22-.251-4.555-1.107-4.555-4.927 0-1.088.39-1.979 1.029-2.675-.103-.252-.446-1.266.098-2.638 0 0 .84-.268 2.75 1.022A9.607 9.607 0 0 1 12 6.82c.85.004 1.705.114 2.504.336 1.909-1.29 2.747-1.022 2.747-1.022.546 1.372.202 2.386.1 2.638.64.696 1.028 1.587 1.028 2.675 0 3.83-2.339 4.673-4.566 4.92.359.307.678.915.678 1.846 0 1.332-.012 2.407-.012 2.734 0 .267.18.577.688.48 3.97-1.32 6.833-5.054 6.833-9.458C22 6.463 17.522 2 12 2Z"
            >
            </path>
          </svg>
          Source Code
        </a>
        <ul class="relative z-10 flex items-center justify-end gap-4 px-4 sm:px-6 lg:px-8">
          <%= if @current_user do %>
            <li class="text-[0.8125rem] leading-6 text-zinc-900">
              <%= @current_user.email %>
            </li>
            <li>
              <.link
                href={~p"/users/settings"}
                class="text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
              >
                Settings
              </.link>
            </li>
            <li>
              <.link
                href={~p"/users/log_out"}
                method="delete"
                class="text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
              >
                Log out
              </.link>
            </li>
          <% else %>
            <li>
              <.link
                href={~p"/users/register"}
                class="text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
              >
                Register
              </.link>
            </li>
            <li>
              <.link
                href={~p"/users/log_in"}
                class="text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
              >
                Log in
              </.link>
            </li>
          <% end %>
        </ul>
        <a
          href={~p"/"}
          class="flex p-4 ml-6 mr-2 transition bg-purple-600 rounded-full text-neutral-100 group hover:text-purple-600 hover:bg-purple-100"
        >
          <span class="text-xs"></span>
          <.icon name="hero-shopping-cart" class="w-5 h-5 stroke-current" />
        </a>
      </ul>
    </nav>
    """
  end
end
