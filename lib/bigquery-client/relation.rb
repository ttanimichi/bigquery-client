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
end
