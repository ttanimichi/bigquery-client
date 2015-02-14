# https://cloud.google.com/bigquery/docs/reference/v2/tabledata

module BigQuery
  module Tabledata
    def insert(table, arg)
      rows = arg.is_a?(Array) ? arg : [arg]
      access_api(
        api_method: bigquery.tabledata.insert_all,
        parameters: {
          tableId: table
        },
        body_object: {
          rows: rows.map { |row| { json: row } }
        }
      )
    end

    def table_data(table)
      access_api(
        api_method: bigquery.tabledata.list,
        parameters: {
          tableId: table
        }
      )
    end
  end
end
