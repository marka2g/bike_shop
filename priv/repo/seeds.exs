alias BikeShop.Accounts
alias BikeShop.Bikes

bikes =
  for _ <- 0..99 do
    {:ok, bike} =
      Bikes.create_bike(%{
        name: Faker.Superhero.descriptor(),
        description: Faker.Superhero.name(),
        image_url: "bike_#{1..25 |> Enum.random()}.jpg",
        price: :rand.uniform(100_000)
      })

    bike
  end

Accounts.register_user(%{
  email: "admin@burningmanbikes.com",
  password: "admin@burningmanbikes.coM1",
  role: "admin"
})

Accounts.register_user(%{
  email: "user@burningmanbikes.com",
  password: "user@burningmanbikes.coM1",
  role: "user"
})
