defmodule BikeShop.Orders.ListOrdersByStatus do
  import Ecto.Query
  alias BikeShop.Orders.Order
  alias BikeShop.Repo

  def execute(status) do
    Order
    |> where([o], o.status == ^status)
    |> order_by([o], desc: o.inserted_at)
    |> preload([o], [:user, items: [:bike]])
    |> Repo.all()
  end
end
