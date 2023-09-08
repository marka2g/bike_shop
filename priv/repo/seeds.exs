alias BikeShop.Bikes

for _ <- 0..99 do
  Bikes.create_bike(%{
    name: Faker.Superhero.descriptor(),
    description: Faker.Superhero.name(),
    image_url: "bike_#{1..25 |> Enum.random()}.jpg",
    price: :rand.uniform(100_000)
  })
end
