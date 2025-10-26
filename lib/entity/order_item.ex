defmodule OrdersTask.OrderItem do

  @tax_rate Decimal.new(23)

  defstruct [:net_price, :quantity, :net_total, :total]

  @type t :: %__MODULE__{
          net_price: Decimal.t(),
          quantity: integer(),
          net_total: Decimal.t(),
          total: Decimal.t() | nil
        }


  @spec new(number() | String.t(), integer()) :: t()
  def new(net_price, quantity) when is_integer(quantity) do
    net_price = Decimal.new(net_price)
    quantity = quantity

    %__MODULE__{
      net_price: net_price,
      quantity: quantity,
      net_total: Decimal.mult(net_price, quantity)
    }
    |> calculate_total()
  end

  def new(_net_price, _quantity) do
    raise ArgumentError, "quantity must be an integer"
  end

  @spec calculate_total(t()) :: t()
  defp calculate_total(order_item = %__MODULE__{}) do
    tax = Decimal.mult(order_item.net_total, @tax_rate) |> Decimal.div(100)
    total = Decimal.add(order_item.net_total, tax)

    %__MODULE__{
      order_item
      | total: Decimal.round(total, 2)
    }
  end
end
