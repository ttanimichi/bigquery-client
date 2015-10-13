module BigQuery
  module Attribute
    class INTEGER < Base
      def parse
        @value.to_i
      end
    end
  end
end
