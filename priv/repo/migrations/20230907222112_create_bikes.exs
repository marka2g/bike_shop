defmodule BikeShop.Repo.Migrations.CreateBikes do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE types as ENUM('pedal', 'electric')"
    drop_query = "DROP TYPE types"
    execute(create_query, drop_query)

    create table(:bikes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :text
      add :image_url, :string
      add :price, :integer
      add :seats, :integer, default: 1
      add :type, :types, default: "pedal", null: false

      timestamps()
    end
  end
end
