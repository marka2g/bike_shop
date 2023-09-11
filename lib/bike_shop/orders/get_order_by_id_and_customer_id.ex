defmodule BikeShop.Orders.GetOrderByIdAndCustomerId do
  import Ecto.Query
  alias BikeShop.Orders.Order
  alias BikeShop.Repo

  def execute(order_id, user_id) do
    Order
    |> where([o], o.id == ^order_id and o.user_id == ^user_id)
    |> Repo.one()
  end
end
