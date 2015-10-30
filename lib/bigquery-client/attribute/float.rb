module BigQuery
  module Attribute
    class Float < Base
      def parse
        return nil if @value.nil?
        @value.to_f
      end
    end
  end
end
