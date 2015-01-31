# https://cloud.google.com/bigquery/docs/reference/v2/tables

module BigQuery
  module Tables
    def create_table(name, schema)
      result = access_api(
        api_method: bigquery.tables.insert,
        body_object: {
          tableReference: {
            tableId: name
          },
          schema: {
            fields: schema
          }
        }
      )
      handle_error(result) if result.error?
    end

    def fetch_schema(table)
      result = access_api(
        api_method: bigquery.tables.get,
        parameters: {
          tableId: table
        }
      )
      handle_error(result) if result.error?
      JSON.parse(result.body)['schema']['fields']
    end
  end
end
