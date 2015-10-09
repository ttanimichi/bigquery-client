module BigQuery
  class Attribute
    attr_reader :name, :type, :value

    def self.build(value, type, name = nil)
      case type
      when 'INTEGER'
        Attribute::Integer.new(value, type, name)
      when 'BOOLEAN'
        Attribute::Boolean.new(value, type, name)
      when 'TIMESTAMP'
        Attribute::Timestamp.new(value, type, name)
      when 'FLOAT'
        Attribute::Float.new(value, type, name)
      when 'STRING'
        Attribute::String.new(value, type, name)
      when 'RECORD'
      # TODO: Add all types
      else
        # TODO: Add an error
        fail "unknown type: #{type}"
      end
    end

    def initialize(value, type, name)
      @value = value
      @type  = type
      @name  = name
    end

    class Integer < Attribute
      def parse
        @value.to_i
      end
    end

    class Boolean < Attribute
      def parse
        @value == 'true'
      end
    end

    class Timestamp < Attribute
      def parse
        Time.parse @value
      end
    end

    class Float < Attribute
      def parse
        @value.to_f
      end
    end

    class String < Attribute
      def parse
        @value
      end
    end
  end
end
