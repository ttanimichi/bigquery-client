module BigQuery
  module Attribute
    class Integer < Base
      def parse
        return nil if @value.nil?
        @value.to_i
      end
    end
  end
end
