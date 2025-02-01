# frozen_string_literal: true

class LineItem
  attr_reader :item, :quantity

  def initialize(item, quantity)
    @item = item
    @quantity = quantity
  end

  def tax
    quantity * item.tax
  end

  def total
    (quantity * item.price_in_cents) + tax
  end
end
