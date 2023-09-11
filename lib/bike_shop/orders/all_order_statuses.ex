defmodule BikeShop.Orders.AllOrderStatuses do
  alias BikeShop.Orders.Order
  alias BikeShop.Repo

  import Ecto.Query

  defstruct all: nil,
            delivered: nil,
            delivering: nil,
            not_started: nil,
            preparing: nil,
            received: nil

  def execute do
    %__MODULE__{}
    |> all
    |> not_started
    |> received
    |> preparing
    |> delivering
    |> delivered
  end

  defp all(struct) do
    all = Order |> select([o], count(o.id)) |> Repo.one()
    %{struct | all: all}
  end

  defp not_started(struct) do
    %{struct | not_started: filter_by_status(:not_started)}
  end

  defp received(struct) do
    %{struct | received: filter_by_status(:received)}
  end

  defp preparing(struct) do
    %{struct | preparing: filter_by_status(:preparing)}
  end

  defp delivering(struct) do
    %{struct | delivering: filter_by_status(:delivering)}
  end

  defp delivered(struct) do
    %{struct | delivered: filter_by_status(:delivered)}
  end

  defp filter_by_status(status) do
    Order
    |> where([o], o.status == ^status)
    |> select([o], count(o.id))
    |> Repo.one()
  end
end
