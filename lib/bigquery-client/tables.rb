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

    def list_tables(options = {})
      result = access_api(
        api_method: bigquery.tables.list,
        parameters: options
      )
      handle_error(result) if result.error?
      JSON.parse(result.body)
    end

    def update_table(name, options = {})
      result = access_api(
        api_method: bigquery.tables.update,
        parameters: {
          tableId: name
        },
        body_object: options
      )
      handle_error(result) if result.error?
      JSON.parse(result.body)
    end

    def patch_table(name, options = {})
      result = access_api(
        api_method: bigquery.tables.patch,
        parameters: {
          tableId: name
        },
        body_object: options
      )
      handle_error(result) if result.error?
      JSON.parse(result.body)
    end

    def fetch_schema(table)
      fetch_table_info(table)['schema']['fields']
    end

    def fetch_table_info(table)
      result = access_api(
        api_method: bigquery.tables.get,
        parameters: {
          tableId: table
        }
      )
      handle_error(result) if result.error?
      JSON.parse(result.body)
    end

    def drop_table(name)
      result = access_api(
        api_method: bigquery.tables.delete,
        parameters: {
          tableId: name
        }
      )
      handle_error(result) if result.error?
    end
  end
end
