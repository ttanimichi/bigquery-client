# https://cloud.google.com/bigquery/docs/reference/v2/tabledata

module BigQuery
  module Tabledata
    def insert(table, arg)
      Service::InsertRows.new(self, table, arg).call
    end

    def insert_all(table, rows)
      access_api(
        api_method: bigquery.tabledata.insert_all,
        parameters: {
          tableId: table[:table_id],
          projectId: table[:project_id],
          datasetId: table[:dataset_id]
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
