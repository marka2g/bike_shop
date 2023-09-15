defmodule BikeShop do
  @moduledoc """
  BikeShop keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  # coveralls-ignore-start
  def public_uploads_path do
    Application.get_env(:bike_shop, :public_uploads_dir, default_public_uploads_path())
  end

  defp default_public_uploads_path do
    "/uploads"
  end

  def uploads_dir do
    Application.get_env(:bike_shop, :uploads_dir, default_uploads_dir())
  end

  defp default_uploads_dir do
    Path.join([:code.priv_dir(:bike_shop), "static", "uploads"])
  end

  # coveralls-ignore-stop
end
