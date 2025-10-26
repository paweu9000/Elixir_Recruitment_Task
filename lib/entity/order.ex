defmodule OrdersTask.Order do
  alias OrdersTask.OrderItem
  alias Decimal

  defstruct net_total: Decimal.new(0),
            tax: Decimal.new(0),
            total: Decimal.new(0),
            items: []

  @type t :: %__MODULE__{
          net_total: Decimal.t(),
          tax: Decimal.t(),
          total: Decimal.t(),
          items: list(OrderItem.t())
        }

  @spec new() :: t()
  def new(), do: %__MODULE__{}

  @spec add_item(t(), OrderItem.t()) :: t()
  def add_item(order = %__MODULE__{}, order_item = %OrderItem{}) do
    updated_items = [order_item | order.items]

    updated_net_total =
      updated_items
      |> Enum.reduce(Decimal.new(0), fn item, acc ->
        Decimal.add(acc, item.net_total)
      end)

    updated_total =
      updated_items
      |> Enum.reduce(Decimal.new(0), fn item, acc ->
        Decimal.add(acc, item.total)
      end)

    updated_tax = Decimal.sub(updated_total, updated_net_total)

    %__MODULE__{
      net_total: updated_net_total,
      tax: updated_tax,
      total: updated_total,
      items: updated_items
    }
  end

end
