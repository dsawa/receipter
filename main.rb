# frozen_string_literal: true

require 'debug'
require_relative 'app/services/shopping_basket_reader'
require_relative 'app/services/receipt_printer'

shopping_basket_inputs = ARGV
shopping_basket_inputs.each do |shopping_basket_input|
  file_path = File.expand_path(shopping_basket_input, File.dirname(__FILE__))
  line_items = ShoppingBasketReader.new(file_path).call
  ReceiptPrinter.new(line_items).call
  puts
end
