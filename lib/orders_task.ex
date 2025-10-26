defmodule OrdersTask do
  alias OrdersTask.OrderItem
  alias OrdersTask.Order

  @spec new_item(number() | String.t(), number() | String.t()) :: OrderItem.t()
  def new_item(net_price, quantity), do: OrderItem.new(net_price, quantity)

  @spec new_order() :: Order.t()
  def new_order(), do: Order.new()

  @spec add_item(Order.t(), OrderItem.t()) :: Order.t()
  def add_item(order = %Order{}, order_item = %OrderItem{}), do: Order.add_item(order, order_item)
end
