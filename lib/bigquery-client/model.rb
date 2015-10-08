require 'ostruct'

module BigQuery
  class Relation < Array
    attr_accessor :schema

    def self.build(column_names, column_types, records)
      tuples = records.map {|record| Tuple.new(column_names, column_types, record) }
      relation = new(tuples)
      relation.schema = [column_names, column_types].transpose.to_h
      relation
    end
  end

  class Tuple
    attr_reader :attributes

    def initialize(names, types, values)
      @attributes = [names, types, values].transpose.map do |array|
        Attribute.build(*array)
      end
    end

    def method_missing(method_name, *args)
      attribute = attributes_hash[method_name.to_s]
      super unless attribute
      attribute.parse
    end

    def attributes_hash
      @attributes_hash ||= [@attributes.map(&:name), @attributes].transpose.to_h
    end
  end

  class Attribute
    attr_reader :name, :type, :value

    def self.build(name, type, value)
      case type
      when 'INTEGER'
        Attribute::Integer.new(name, type, value)
      when 'BOOLEAN'
        Attribute::Boolean.new(name, type, value)
      when 'TIMESTAMP'
        Attribute::Timestamp.new(name, type, value)
      when 'FLOAT'
        Attribute::Float.new(name, type, value)
      when 'STRING'
        Attribute::String.new(name, type, value)
      when 'RECORD'
      # TODO: Add all types
      else
        # TODO: Add an error
        fail "unknown type: #{type}"
      end
    end

    def initialize(name, type, value)
      @name  = name
      @type  = type
      @value = value
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
