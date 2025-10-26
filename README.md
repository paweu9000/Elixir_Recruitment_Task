# Zadanie rekrutacyjne

Moje rozwiązanie zadania.

## Typy

Order
1. net_total - DECIMAL(10,2)
2. tax - DECIMAL(10,2)
3. total - DECIMAL(10,2)
4. items - relacja one to many (wiele order items do jednego orderu)

OrderItem
1. net_price - DECIMAL(10,2)
2. quantity - INTEGER
3. net_total - DECIMAL(10,2)
4. total - DECIMAL(10,2)

## Użycie
Są 3 funkcje:
1. OrdersTask.new_item(String[dla wartości po przecinku]/int, int) - Tworzy nowy OrderItem
2. OrdersTask.new_order() - Tworzy nowy Order
3. OrdersTask.add_item(Order, OrderItem) - Dodaje OrderItem do Orderu i kalkuluje przy tym pola orderu

```bash
iex -S mix
```

```iex
iex> item1 = OrdersTask.new_item("12.99", 7)
%OrdersTask.OrderItem{
  net_price: Decimal.new("12.99"),
  quantity: 7,
  net_total: Decimal.new("90.93"),
  total: Decimal.new("111.84")
}
iex> item2 = OrdersTask.new_item(9, 4)
%OrdersTask.OrderItem{
  net_price: Decimal.new("9"),
  quantity: 4,
  net_total: Decimal.new("36"),
  total: Decimal.new("44.28")
}
iex> order = OrdersTask.new_order()
%OrdersTask.Order{
  net_total: Decimal.new("0"),
  tax: Decimal.new("0"),
  total: Decimal.new("0"),
  items: []
}
iex> order |> OrdersTask.add_item(item1) |> OrdersTask.add_item(item2)
%OrdersTask.Order{
  net_total: Decimal.new("126.93"),
  tax: Decimal.new("29.19"),
  total: Decimal.new("156.12"),
  items: [
    %OrdersTask.OrderItem{
      net_price: Decimal.new("9"),
      quantity: 4,
      net_total: Decimal.new("36"),
      total: Decimal.new("44.28")
    },
    %OrdersTask.OrderItem{
      net_price: Decimal.new("12.99"),
      quantity: 7,
      net_total: Decimal.new("90.93"),
      total: Decimal.new("111.84")
    }
  ]
}
```

## Testy
```bash
mix test
```

## Użyte biblioteki

Decimal - [Link do hexdocs](https://hexdocs.pm/decimal/readme.html)