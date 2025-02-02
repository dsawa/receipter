# frozen_string_literal: true

class TaxCalculator
  BASE_TAX_RATE = 0.1
  IMPORT_DUTY_RATE = 0.05
  ROUND_CENTS_RATE = 5
  EXEMPT_CATEGORIES = %i[food medical book].freeze

  attr_reader :item

  def initialize(item)
    @item = item
  end

  def call
    tax = 0
    tax += base_tax unless tax_exempt?
    tax += import_duty if item.imported?

    round_to_nearest(tax)
  end

  private

  def tax_exempt?
    EXEMPT_CATEGORIES.include?(item.category)
  end

  def base_tax
    item.price_in_cents * BASE_TAX_RATE
  end

  def import_duty
    item.price_in_cents * IMPORT_DUTY_RATE
  end

  def round_to_nearest(value)
    ((value / ROUND_CENTS_RATE).ceil * ROUND_CENTS_RATE)
  end
end
