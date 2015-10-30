# https://cloud.google.com/bigquery/docs/reference/v2/tabledata

module BigQuery
  module Tabledata
    def insert(table, arg)
      InsertRows.new(self, table, arg).call
    end

    def insert_all(table, rows)
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

    def list_tabledata(table)
      access_api(
        api_method: bigquery.tabledata.list,
        parameters: {
          tableId: table
        }
      )
    end
  end
end
