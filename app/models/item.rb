# frozen_string_literal: true

class Item
  # Simple categorization based on keywords in the product name
  CATEGORY_KEYWORDS = {
    medical: %w[pills medicine medication antibiotic bandage syrup ointment inhaler drops],
    food: %w[chocolate candy gum chips cookie cake pie bread], # Probably should handle more :)
    book: %w[book]
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
    end&.first
  end

  def tax
    raise NotImplementedError, 'Implement Tax calculation logic'
  end
end
