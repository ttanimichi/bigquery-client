module BigQuery
  module Attribute
    class Timestamp < Base
      def parse
        return nil if @value.nil?
        Time.at(@value.to_f)
      end
    end
  end
end
