# https://cloud.google.com/bigquery/docs/reference/v2/tabledata

module BigQuery
  module Tabledata
    class InsertError < StandardError
    end

    def insert(table, arg)
      rows = arg.is_a?(Array) ? arg : [arg]
      result = access_api(
        api_method: bigquery.tabledata.insert_all,
        parameters: {
          tableId: table
        },
        body_object: {
          rows: rows.map { |row| { json: row } }
        }
      )
      if result['insertErrors']
        fail InsertError, result['insertErrors']
      end
    end

    def list_tabledata(table)
      access_api(
        api_method: bigquery.tabledata.list,
        parameters: {
          tableId: table
        }
      )
    end

    alias_method :insert_all, :insert
  end
end
