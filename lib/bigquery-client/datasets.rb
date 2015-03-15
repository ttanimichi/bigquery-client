# https://cloud.google.com/bigquery/docs/reference/v2/datasets

module BigQuery
  module Datasets
    def datasets
      list_datasets['datasets'].map {|dataset| dataset['datasetReference']['datasetId'] }
    end

    def list_datasets
      access_api(
        api_method: bigquery.datasets.list
      )
    end

    def fetch_dataset
      raise NotImplementedError
    end

    def create_dataset(name)
      access_api(
        api_method: bigquery.datasets.insert,
        body_object: {
          datasetReference: {
            datasetId: name
          }
        }
      )
    end

    def patch_dataset
      raise NotImplementedError
    end

    def update_dataset
      raise NotImplementedError
    end

    def delete_dataset(name)
      access_api(
        api_method: bigquery.datasets.delete,
        parameters: {
          datasetId: name,
          deleteContents: true
        }
      )
    end
  end
end
