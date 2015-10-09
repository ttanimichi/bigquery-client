module BigQuery
  class Tuple
    attr_reader :attributes

    def initialize(names, types, values)
      @attributes = [values, types, names].transpose.map do |array|
        Attribute.build(*array)
      end

      @attributes.each do |attribute|
        define_singleton_method(attribute.name) do
          attribute.parse
        end
      end
    end

    def attributes_hash
      @attributes_hash ||= [@attributes.map(&:name), @attributes].transpose.to_h
    end
  end
end
