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
      @attributes = [values, types, names].transpose.map do |array|
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
