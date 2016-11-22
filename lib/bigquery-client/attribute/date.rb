module BigQuery
  module Attribute
    class Date < Base
      def parse
        return nil if @value.nil?
        ::Date.parse(@value)
      end
    end
  end
end
