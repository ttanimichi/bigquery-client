module BigQuery
  module Attribute
    class TIMESTAMP < Base
      def parse
        Time.at(@value.to_f)
      end
    end
  end
end
