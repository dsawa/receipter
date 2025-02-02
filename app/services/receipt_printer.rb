# frozen_string_literal: true

class ReceiptPrinter
  attr_reader :line_items

  def initialize(line_items)
    @line_items = line_items
    @total_tax = 0
    @total = 0
  end

  def call
    print_line_items
    print_summary
  end

  private

  def print_line_items
    line_items.each do |line_item|
      line_item_tax = line_item.tax
      line_item_total = line_item.total

      @total_tax += line_item_tax
      @total += line_item_total

      puts format("#{line_item.quantity} #{line_item.item.product_name}: %.2f", (line_item_total / 100.to_f))
    end
  end

  def print_summary
    puts format('Sales Taxes: %.2f', (@total_tax / 100.to_f))
    puts format('Total: %.2f', (@total / 100.to_f))
  end
end
