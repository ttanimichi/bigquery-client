# https://cloud.google.com/bigquery/docs/reference/v2/jobs

module BigQuery
  module Jobs
    def sql(query, options = {})
      query(query, options).to_a
    end

    def query(query, options = {})
      RunQuery.new(self, query, options).call
    end

      # jobs_query_response = jobs_query(query, options)
      # fields = jobs_query_response['schema']['fields']
      # # こいつらはインスタンス変数
      # names = fields.map {|field| field['name'] } # カラム名
      # types = fields.map {|field| field['type'] } # カラムの型
      # # こいつもインスタンス変数
      # records = extract_records(jobs_query_response)
      # # jobId がたぶんユニークだから jobId が違ったら結合できないようにする、とか
      # job_id = jobs_query_response['jobReference']['jobId']
      # page_token = jobs_query_response['pageToken']
      # while page_token
      #   query_results_response = query_results(job_id, { pageToken: page_token }.merge(options))
      #   records += extract_records(query_results_response)
      #   page_token = query_results_response['pageToken']
      # end
      # convert(records, types).map { |values| [names, values].transpose.to_h }

    def jobs_query(query, options = {})
      default = { query: query, timeoutMs: 600_000 }
      access_api(
        api_method: bigquery.jobs.query,
        body_object: default.merge(options)
      )
    end

    def load(options = {})
      access_api(
        api_method: bigquery.jobs.insert,
        body_object: {
          configuration: {
            load: options
          }
        }
      )
    end

    def jobs(options = {})
      access_api(
        api_method: bigquery.jobs.list,
        parameters: options
      )
    end

    def fetch_job(id, options = {})
      access_api(
        api_method: bigquery.jobs.get,
        parameters: { jobId: id }.merge(options)
      )
    end

    def query_results(id, options = {})
      access_api(
        api_method: bigquery.jobs.get_query_results,
        parameters: { jobId: id }.merge(options)
      )
    end
  end
end
