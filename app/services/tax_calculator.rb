# frozen_string_literal: true

require_relative 'logger_builder'

class TaxCalculator
  BASE_TAX_RATE = 0.1
  IMPORT_DUTY_RATE = 0.05
  ROUND_CENTS_RATE = 5
  EXEMPT_CATEGORIES = %i[food medical book].freeze

  attr_reader :item, :logger

  def initialize(item, logger = LoggerBuilder.build)
    @item = item
    @logger = logger
  end

  def call
    logger.debug("Calculating tax for: #{item.product_name} - #{item.price_in_cents} - #{item.category}")

    tax = 0
    tax += base_tax
    tax += import_duty

    rounded_tax = round_to_nearest(tax)
    logger.debug("Tax calculated: #{rounded_tax}")

    rounded_tax
  end

  private

  def tax_exempt?
    EXEMPT_CATEGORIES.include?(item.category)
  end

  def base_tax
    return 0 if tax_exempt?

    item.price_in_cents * BASE_TAX_RATE
  end

  def import_duty
    return 0 unless item.imported?

    item.price_in_cents * IMPORT_DUTY_RATE
  end

  def round_to_nearest(value)
    ((value / ROUND_CENTS_RATE).ceil * ROUND_CENTS_RATE)
  end
end
