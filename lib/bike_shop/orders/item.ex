defmodule BikeShop.Orders.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias BikeShop.Bikes.Bike

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "items" do
    field :quantity, :integer
    belongs_to :bike, Bike
    field :order_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:quantity, :bike_id])
    |> validate_required([:quantity, :bike_id])
  end
end
