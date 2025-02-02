# frozen_string_literal: true

require 'logger'

class LoggerBuilder
  def self.build
    Logger.new($stdout, level: ENV['DEBUG'] ? Logger::DEBUG : Logger::INFO)
  end
end
