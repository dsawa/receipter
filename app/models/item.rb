# frozen_string_literal: true

require_relative '../services/tax_calculator'

class Item
  # Simple categorization based on keywords in the product name
  CATEGORY_KEYWORDS = {
    medical: %w[pills medicine medication antibiotic bandage syrup ointment inhaler drops].freeze,
    food: %w[chocolate candy gum chips cookie cake pie bread].freeze, # Probably should handle more :)
    book: %w[book].freeze
  }.freeze

  attr_reader :product_name, :price_in_cents

  def initialize(product_name, price_in_cents)
    @product_name = product_name
    @price_in_cents = price_in_cents
  end

  def imported?
    product_name.include?('imported')
  end

  def category
    CATEGORY_KEYWORDS.find do |_, keywords|
      keywords.any? { |keyword| product_name.downcase.include?(keyword) }
    end&.first || :other
  end

  def tax
    TaxCalculator.new(self).call
  end
end
