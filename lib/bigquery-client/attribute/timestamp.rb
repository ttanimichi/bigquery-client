module BigQuery
  module Attribute
    class TIMESTAMP < Base
      def parse
        Time.parse @value
      end
    end
  end
end
