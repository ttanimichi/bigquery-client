module BigQuery
  class Relation < Array

    def self.build(column_names, column_types, records)
      tuples = records.map {|record| Tuple.new(column_names, column_types, record) }
      relation = new(tuples)
      relation.schema =
      relation
    end

    def initialize(column_names, column_types, records)
      tuples = records.map {|record| Tuple.new(column_names, column_types, record) }
      super(tuples)
    end

    def schema
      @schema ||= [@column_names, @column_types].transpose.to_h
    end

    # def first
    #   self[0]
    # end

    # def last
    #   self[-1]
    # end
  end
end
