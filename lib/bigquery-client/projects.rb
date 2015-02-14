# https://cloud.google.com/bigquery/docs/reference/v2/projects

module BigQuery
  module Projects
    def projects
      list_projects['projects'].map {|project| project['id'] }
    end

    def list_projects
      access_api(
        api_method: bigquery.projects.list
      )
    end
  end
end
