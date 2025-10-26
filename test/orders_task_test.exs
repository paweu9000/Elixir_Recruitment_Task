defmodule OrdersTaskTest do
  use ExUnit.Case
  doctest OrdersTask

  alias OrdersTask.OrderItem
  alias OrdersTask.Order

  test "create new order item works" do
    assert OrdersTask.new_item(12, 8) == %OrderItem{
      net_price: Decimal.new("12"),
      quantity: 8,
      net_total: Decimal.new("96"),
      total: Decimal.new("118.08")
    }

    assert OrdersTask.new_item(6, 6) == %OrderItem{
      net_price: Decimal.new("6"),
      quantity: 6,
      net_total: Decimal.new("36"),
      total: Decimal.new("44.28")
    }

    assert OrdersTask.new_item("36", 2) == %OrderItem{
      net_price: Decimal.new("36"),
      quantity: 2,
      net_total: Decimal.new("72"),
      total: Decimal.new("88.56")
    }
  end

  test "raise error when quantity is not an integer type" do
    assert_raise ArgumentError, "quantity must be an integer", fn ->
      OrdersTask.new_item(12, "ABC")
    end

    assert_raise ArgumentError, "quantity must be an integer", fn ->
      OrdersTask.new_item(12, "32")
    end

    assert_raise ArgumentError, "net_price must be either integer or float in string form", fn ->
      OrdersTask.new_item(12.99, 12)
    end
  end

  test "create new order works" do
    assert OrdersTask.new_order() == %Order{
      net_total: Decimal.new(0),
      tax: Decimal.new(0),
      total: Decimal.new(0),
      items: []
    }
  end

  test "adding items to an order works" do
    item1 = OrdersTask.new_item(12, 8)
    item2 = OrdersTask.new_item(6, 6)
    item3 = OrdersTask.new_item(36, 2)

    order =
      OrdersTask.new_order()
      |> OrdersTask.add_item(item1)
      |> OrdersTask.add_item(item2)
      |> OrdersTask.add_item(item3)

    assert order == %Order{
      net_total: Decimal.new(204),
      tax: Decimal.new("46.92"),
      total: Decimal.new("250.92"),
      items: [
        item3, item2, item1
      ]
    }
  end
end
