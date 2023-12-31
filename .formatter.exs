[
  import_deps: [:ecto, :ecto_sql, :phoenix],
  subdirectories: ["priv/*/migrations"],
  plugins: [Phoenix.LiveView.HTMLFormatter],
  inputs:
    Enum.flat_map(
      [
        "*.{heex,ex,exs}",
        "{mix,.formatter}.exs",
        "{config,lib,test}/**/*.{heex,ex,exs}",
        "priv/*/seeds.exs"
      ],
      &Path.wildcard(&1, match_dot: true)
    ) --
      [
        ".scratch.ex",
        ".notes.ex",
        "lib/bike_shop_web/components/core_components.ex",
        "lib/bike_shop/carts/core/handle_carts.ex"
      ]
]
