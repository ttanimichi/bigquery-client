module BigQuery
  module Attribute
    class UnknownType < StandardError
    end

    def self.new(value, type, name = nil)
      if klass = BigQuery::Attribute.const_get(type)
        klass.new(value, type, name)
      else
        fail UnknownType, "unknown type: #{type}"
      end
    end
  end
end
