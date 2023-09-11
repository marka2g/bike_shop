defmodule BikeShop.Carts.Core.HandleCarts do
  alias BikeShop.Carts.Data.Cart

  def create(cart_id), do: Cart.new(cart_id)

  def add(cart, item) do
    new_total_price = Money.add(cart.total_price, item.price)
    new_items = new_item(cart.items, item)

    %{
      cart
      | total_quantity: cart.total_quantity + 1,
        items: new_items,
        total_price: new_total_price
    }
  end

  defp new_item(items, item) do
    item_in_cart? =
      Enum.find(items, &(&1.item.id == item.id))

    if item_in_cart? == nil do
      items ++ [%{item: item, quantity: 1}]
    else
      items
      |> Map.new(fn item -> {item.item.id, item} end)
      |> Map.update!(item.id, &%{&1 | quantity: &1.quantity + 1})
      |> Map.values()
    end
  end

  def remove(cart, item_id) do
    {items, item_removed} = Enum.reduce(cart.items, {[], nil}, &remove_item(&1, &2, item_id))
    total_price_to_be_removed = Money.multiply(item_removed.item.price, item_removed.quantity)
    total_price = Money.subtract(cart.total_price, total_price_to_be_removed)

    %{
      cart
      | items: items,
        total_quantity: cart.total_quantity - item_removed.quantity,
        total_price: total_price
    }
  end

  defp remove_item(item, acc, item_id) do
    {items_list, item_acc} = acc

    if item.item.id == item_id do
      {items_list, item}
    else
      {[item] ++ items_list, item_acc}
    end
  end

  def inc(%{items: items} = cart, item_id) do
    {items_updated, item} =
      Enum.reduce(items, {[], nil}, fn item_detail, acc ->
        {items_list, item} = acc

        if item_detail.item.id == item_id do
          updated_item = %{item_detail | quantity: item_detail.quantity + 1}

          item_updated = [updated_item]
          {items_list ++ item_updated, updated_item}
        else
          {[item_detail] ++ items_list, item}
        end
      end)

    total_price = Money.add(cart.total_price, item.item.price)

    %{
      cart
      | items: items_updated,
        total_quantity: cart.total_quantity + 1,
        total_price: total_price
    }
  end

  def dec(%{items: items} = cart, item_id) do
    {items_updated, item} =
      Enum.reduce(items, {[], nil}, fn item_detail, acc ->
        {items_list, item} = acc

        if item_detail.item.id == item_id do
          updated_item = %{item_detail | quantity: item_detail.quantity - 1}

          if updated_item == 0 do
            {items_list, updated_item}
          else
            item_updated = [updated_item]
            {items_list ++ item_updated, updated_item}
          end
        else
          {[item_detail] ++ items_list, item}
        end
      end)

    total_price = Money.subtract(cart.total_price, item.item.price)

    %{
      cart
      | items: items_updated,
        total_quantity: cart.total_quantity - 1,
        total_price: total_price
    }
  end
end
