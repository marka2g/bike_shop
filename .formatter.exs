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
        "priv/*/seeds.exs",
        "lib/bike_shop_web/components/core_components.ex"
      ],
      &Path.wildcard(&1, match_dot: true)
    ) -- [".scratch.ex", ".notes.ex"]
]
