module BigQuery
  module Attribute
    class Base
      attr_reader :name, :type, :value

      def initialize(value, type, name)
        @value = value
        @type  = type
        @name  = name
      end
    end
  end
end
