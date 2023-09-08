defmodule BikeShop.Repo.Migrations.AddUserRoles do
  use Ecto.Migration

  def change do
    query = "CREATE TYPE roles as ENUM('user', 'admin')"
    drop = "DROP TYPE roles"
    execute(query, drop)

    alter table(:users) do
      add :role, :roles, default: "user", null: false
    end
  end
end
