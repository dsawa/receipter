# frozen_string_literal: true

require 'logger'
require_relative 'shopping_basket_reader'
require_relative 'receipt_printer'

class ProcessService
  attr_reader :shopping_basket_inputs, :logger

  def initialize(shopping_basket_inputs, logger = LoggerBuilder.build)
    @shopping_basket_inputs = shopping_basket_inputs
    @logger = logger
  end

  def call
    shopping_basket_inputs.each do |shopping_basket_input|
      logger.debug("Processing argument: #{shopping_basket_input}")
      file_path = File.expand_path(shopping_basket_input, root_app_path)

      logger.debug("Reading shopping basket from: #{file_path}")
      line_items = ShoppingBasketReader.new(file_path, logger).call

      logger.debug("Printing receipt for: #{file_path}")
      ReceiptPrinter.new(line_items).call
      puts
    end
  end

  private

  def root_app_path
    File.expand_path('../..', File.dirname(__FILE__))
  end
end
