# https://cloud.google.com/bigquery/docs/reference/v2/datasets

module BigQuery
  module Datasets
    def list_datasets
      result = access_api(
        api_method: bigquery.datasets.list,
        parameters: {
        }
      )
      JSON.parse(result.body)
    end
  end
end
