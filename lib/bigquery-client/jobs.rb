# https://cloud.google.com/bigquery/docs/reference/v2/jobs

module BigQuery
  module Jobs
    def sql(query, options = {})
      jobs_query_response = jobs_query(query, options)
      fields = jobs_query_response['schema']['fields']
      names = fields.map {|field| field['name'] }
      types = fields.map {|field| field['type'] }
      records = extract_records(jobs_query_response)
      job_id = jobs_query_response['jobReference']['jobId']
      page_token = jobs_query_response['pageToken']

      while page_token
        query_results_response = query_results(job_id, { pageToken: page_token }.merge(options))
        records += extract_records(query_results_response)
        page_token = query_results_response['pageToken']
      end

      convert(records, types).map { |values| [names, values].transpose.to_h }
    end

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

    private

    def extract_records(response)
      (response['rows'] || []).map {|row| row['f'].map {|record| record['v'] } }
    end

    def convert(records, types)
      records.map do |values|
        values.map.with_index do |value, index|
          case types[index]
          when 'INTEGER'
            value.to_i
          when 'BOOLEAN'
            value == 'true'
          else
            value
          end
        end
      end
    end
  end
end
