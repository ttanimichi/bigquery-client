# https://cloud.google.com/bigquery/docs/reference/v2/projects

module BigQuery
  module Projects
    def list_projects
      result = access_api(
        api_method: bigquery.projects.list,
        parameters: {
        }
      )
      JSON.parse(result.body)
    end
  end
end
