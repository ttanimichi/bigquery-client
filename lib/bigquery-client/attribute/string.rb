module BigQuery
  module Attribute
    class STRING < Base
      def parse
        @value
      end
    end
  end
end
