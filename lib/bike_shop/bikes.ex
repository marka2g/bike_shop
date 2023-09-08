defmodule BikeShop.Bikes do
  @moduledoc """
  The Bikes context.
  """

  import Ecto.Query, warn: false
  alias BikeShop.Repo

  alias BikeShop.Bikes.Bike

  @doc """
  Returns the list of bikes.

  ## Examples

      iex> list_bikes()
      [%Bike{}, ...]

  """
  def list_bikes(params \\ []) do
    query = from(b in Bike)

    params
    |> Enum.reduce(query, fn
      {:name, name}, query ->
        name = "%" <> name <> "%"
        where(query, [q], ilike(q.name, ^name))
    end)
    |> Repo.all()
  end

  def list_suggest_names(name) do
    name = "%" <> name <> "%"

    Bike
    |> where([p], ilike(p.name, ^name))
    |> select([p], p.name)
    |> Repo.all()
  end

  @doc """
  Gets a single bike.

  Raises `Ecto.NoResultsError` if the Bike does not exist.

  ## Examples

      iex> get_bike!(123)
      %Bike{}

      iex> get_bike!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bike!(id), do: Repo.get!(Bike, id)

  @doc """
  Creates a bike.

  ## Examples

      iex> create_bike(%{field: value})
      {:ok, %Bike{}}

      iex> create_bike(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bike(attrs \\ %{}) do
    %Bike{}
    |> Bike.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bike.

  ## Examples

      iex> update_bike(bike, %{field: new_value})
      {:ok, %Bike{}}

      iex> update_bike(bike, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bike(%Bike{} = bike, attrs) do
    bike
    |> Bike.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bike.

  ## Examples

      iex> delete_bike(bike)
      {:ok, %Bike{}}

      iex> delete_bike(bike)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bike(%Bike{} = bike) do
    Repo.delete(bike)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bike changes.

  ## Examples

      iex> change_bike(bike)
      %Ecto.Changeset{data: %Bike{}}

  """
  def change_bike(%Bike{} = bike, attrs \\ %{}) do
    Bike.changeset(bike, attrs)
  end
end
