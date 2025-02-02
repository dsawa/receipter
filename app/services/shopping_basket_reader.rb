# frozen_string_literal: true

require_relative '../models/item'
require_relative '../models/line_item'
require_relative '../services/logger_builder'

class ShoppingBasketReader
  attr_reader :file_path, :logger

  def initialize(file_path, logger = LoggerBuilder.build)
    @file_path = file_path
    @logger = logger
  end

  def call
    File.foreach(file_path).map do |line|
      match = line.match(/^\s*(\d+)\s+(.*?)\s+at\s+(\d+\.\d{1,2})\s*$/)

      raise_error("Shopping Basket format invalid, line: #{line}") unless match

      quantity, product_name, price = match.captures

      price_in_cents = price.delete('.').to_i
      item = Item.new(product_name, price_in_cents)
      LineItem.new(item, quantity.to_i)
    end
  end

  private

  def raise_error(msg)
    logger.error(msg)
    raise msg
  end
end
