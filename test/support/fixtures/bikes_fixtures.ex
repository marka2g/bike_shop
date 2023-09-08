defmodule BikeShop.BikesFixtures do
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
        image_url: "some image_url",
        price: 42,
        seats: 42
      })
      |> BikeShop.Bikes.create_bike()

    bike
  end
end
