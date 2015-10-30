module BigQuery
  module Attribute
    class Base
      attr_reader :name, :type, :value

      def initialize(name, value)
        @name, @value = name, value
        @type = self.class.name.split('::').last.downcase.to_sym
      end

      def parse
      end
    end
  end
end
