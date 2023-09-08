defmodule BikeShop.BikeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BikeShop.Bikes` context.
  """

  @doc """
  Generate a bike.
  """
  def bike_fixture(attrs \\ %{}) do
    {:ok, bike} =
      attrs
      |> Enum.into(%{
        name: "some name",
        type: :pedal,
        description: "some description",
        image_url: "bike_1.jpg",
        price: 42,
        seats: 1
      })
      |> BikeShop.Bikes.create_bike()

    bike
  end
end
