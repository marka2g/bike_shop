defmodule BikeShop.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias BikeShop.Accounts.User
  alias BikeShop.Orders.Item

  @status_values ~w/not_started received preparing delivering delivered/a
  @fields ~w/status/a
  @required ~w/total_price total_quantity user_id address phone_number/a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :address, :string
    field :phone_number, :string
    field :total_price, Money.Ecto.Amount.Type
    field :total_quantity, :integer
    field :status, Ecto.Enum, values: @status_values, default: :not_started

    belongs_to :user, User
    has_many :items, Item

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, @fields ++ @required)
    |> validate_required(@required)
    |> validate_number(:total_quantity, greater_than: 0)
    |> cast_assoc(:items, with: &Item.changeset/2)
  end
end
