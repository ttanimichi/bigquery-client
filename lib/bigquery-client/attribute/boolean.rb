module BigQuery
  module Attribute
    class BOOLEAN < Base
      def parse
        @value == 'true'
      end
    end
  end
end
