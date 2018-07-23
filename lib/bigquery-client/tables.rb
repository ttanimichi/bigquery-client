# https://cloud.google.com/bigquery/docs/reference/v2/tables

module BigQuery
  module Tables
    def tables(options = {})
      Service::FetchTables.new(self, options).call
    end

    def list_tables(options = {})
      access_api(
        api_method: bigquery.tables.list,
        parameters: options
      )
    end

    def fetch_schema(table)
      fetch_table(table)['schema']['fields']
    end

    def fetch_table(table)
      access_api(
        api_method: bigquery.tables.get,
        parameters: {
          tableId: table
        }
      )
    end

    def create_table(table, schema)
      access_api(
        api_method: bigquery.tables.insert,
        body_object: {
          tableReference: {
            tableId: table
          },
          schema: {
            fields: schema
          }
        }
      )
    end

    def patch_table(table, schema)
      access_api(
        api_method: bigquery.tables.patch,
        parameters: {
          tableId: table
        },
        body_object: {
          schema: {
            fields: schema
          }
        }
      )
    end

    def update_table(table, schema)
      access_api(
        api_method: bigquery.tables.update,
        parameters: {
          tableId: table
        },
        body_object: {
          schema: {
            fields: schema
          }
        }
      )
    end

    def extract_table(source_table, options = {})
      default = { sourceTable: source_table }
      access_api(
        api_method: bigquery.jobs.insert,
        body_object: {
          configuration: {
            extract: default.merge(options)
          }
        }
      )
    end

    def delete_table(table, options = {})
      access_api(
        api_method: bigquery.tables.delete,
        parameters: options.merge({ tableId: table })
      )
    end
  end
end
