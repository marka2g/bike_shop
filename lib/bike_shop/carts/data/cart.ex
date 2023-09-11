defmodule BikeShop.Carts.Data.Cart do
  defstruct id: nil,
            items: [],
            total_price: Money.new(0),
            total_quantity: 0

  def new(id), do: %__MODULE__{id: id}
end
