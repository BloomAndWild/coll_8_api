# frozen_string_literal: true

module Coll8Api
  module Errors
    class AbstractMethodError < StandardError
      ERROR_MSG = 'method must be implemented in a subclass'

      def initialize
        super(ERROR_MSG)
      end
    end
  end
end