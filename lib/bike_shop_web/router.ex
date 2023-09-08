defmodule BikeShopWeb.Router do
  use BikeShopWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BikeShopWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BikeShopWeb do
    pipe_through :browser

    live "/", ShopLive, :index

    scope "/admin", Admin, as: :admin do
      live "/bikes", BikeLive.Index, :index
      live "/bikes/new", BikeLive.Index, :new
      live "/bikes/:id/edit", BikeLive.Index, :edit

      live "/bikes/:id", BikeLive.Show, :show
      live "/bikes/:id/show/edit", BikeLive.Show, :edit
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", BikeShopWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:bike_shop, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BikeShopWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
