module BigQuery
  module Attribute
    class String < Base
      def parse
        @value
      end
    end
  end
end
