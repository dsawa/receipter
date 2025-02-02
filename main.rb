# frozen_string_literal: true

require 'logger'
require_relative 'app/services/process_service'

logger = Logger.new($stdout, level: ENV['DEBUG'] ? Logger::DEBUG : Logger::INFO)
shopping_basket_inputs = ARGV

ProcessService.new(shopping_basket_inputs, logger).call
