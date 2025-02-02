# frozen_string_literal: true

require 'logger'
require_relative 'app/services/shopping_basket_reader'
require_relative 'app/services/receipt_printer'

logger = Logger.new($stdout, level: ENV['DEBUG'] ? Logger::DEBUG : Logger::INFO)

shopping_basket_inputs = ARGV
shopping_basket_inputs.each do |shopping_basket_input|
  logger.debug("Processing argument: #{shopping_basket_input}")
  file_path = File.expand_path(shopping_basket_input, File.dirname(__FILE__))

  logger.debug("Reading shopping basket from: #{file_path}")
  line_items = ShoppingBasketReader.new(file_path, logger).call

  logger.debug("Printing receipt for: #{file_path}")
  ReceiptPrinter.new(line_items).call
end
