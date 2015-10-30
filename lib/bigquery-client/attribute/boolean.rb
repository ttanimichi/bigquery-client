module BigQuery
  module Attribute
    class Boolean < Base
      def parse
        case @value
        when nil     then nil
        when 'true'  then true
        when 'false' then false
        end
      end
    end
  end
end
