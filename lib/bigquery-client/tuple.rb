module BigQuery
  class Tuple
    def initialize(names, types, values)
      @names  = names
      @types  = types
      @values = values

      attributes.each do |attribute|
        define_singleton_method(attribute.name) do
          attribute.parse
        end
      end
    end

    def attributes
      @attributes ||= [@values, @types, @names].transpose.map do |array|
        Attribute.new(*array)
      end
    end

    def attributes_hash
      @attributes_hash ||= [@attributes.map(&:name), @attributes].transpose.to_h
    end

    def inspect
      @values
    end

    def to_s
      attributes
    end
  end
end
