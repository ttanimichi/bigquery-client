module BigQuery
  class ResultSet < Struct.new(:job_id, :column_names, :column_types, :records)
    def to_a
      records.map {|record|
        values = record.map.with_index do |value, index|
          Attribute.new(value, column_types[index]).parse
        end
        [column_names, values].transpose.to_h
      }
    end
  end
end
