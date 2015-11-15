module BigQuery
  module Attribute
    class UnknownType < StandardError
    end

    def self.new(name: nil, type: nil, value: nil)
      class_name = (type[0] || '').upcase + (type[1..-1] || '').downcase
      if klass = const_get(class_name)
        klass.new(name, value)
      else
        fail UnknownType, "unknown type: #{type}"
      end
    end
  end
end
