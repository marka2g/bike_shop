defmodule BikeShop.Bikes.Bike do
  use Ecto.Schema
  import Ecto.Changeset

  @bike_types ~w/pedal electric/a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "bikes" do
    field :name, :string
    field :type, Ecto.Enum, values: @bike_types, default: :pedal
    field :description, :string
    field :image_url, :string
    field :price, Money.Ecto.Amount.Type
    field :seats, :integer

    timestamps()
  end

  @required_fields ~w(name price)a
  @optional_fields ~w(description seats type image_url)a

  @doc false
  def changeset(bike, attrs) do
    bike
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
