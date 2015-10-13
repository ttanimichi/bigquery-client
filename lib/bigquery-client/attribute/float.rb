module BigQuery
  module Attribute
    class FLOAT < Base
      def parse
        @value.to_f
      end
    end
  end
end

