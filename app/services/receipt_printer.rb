# frozen_string_literal: true

# frozent_string_literal: true

class ReceiptPrinter
  attr_reader :line_items

  def initialize(line_items)
    @line_items = line_items
  end

  def call
    print_line_items
    print_summary
  end

  private

  def print_line_items
    line_items.each do |line_item|
      puts format("#{line_item.quantity} #{line_item.item.product_name}: %.2f", (line_item.total / 100.to_f))
    end
  end

  def print_summary
    puts format('Sales Taxes: %.2f', (line_items.sum(&:tax) / 100.to_f))
    puts format('Total: %.2f', (line_items.sum(&:total) / 100.to_f))
  end
end
