# https://cloud.google.com/bigquery/docs/reference/v2/tabledata

module BigQuery
  module Tabledata
    def insert(table, args)
      rows = args.is_a?(Array) ? args : [args]
      result = access_api(
        api_method: bigquery.tabledata.insert_all,
        parameters: {
          tableId: table
        },
        body_object: {
          rows: rows.map { |row| { json: row } }
        }
      )
      handle_error(result) if result.error?
    end
  end
end
