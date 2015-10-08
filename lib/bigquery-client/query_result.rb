module BigQuery
  class ResultSet < Struct.new(:job_id, :column_names, :column_types, :records)




    def to_a
      records.map {|values|
        values.map.with_index {|value, index|
          case column_types[index]
          when 'INTEGER'
            value.to_i
          when 'BOOLEAN'
            value == 'true'
          when 'TIMESTAMP'
            Time.parse value
          when 'FLOAT'
            value.to_f
          when 'STRING'
            value
          else
            value
          end
        }
      }.map {|values|
        [column_names, values].transpose.to_h
      }
    end
  end
end
