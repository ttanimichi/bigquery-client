module BigQuery
  class RunQuery
    def initialize(client, query, options = {})
      @client = client
      @query = query
      @options = options
    end

    def call
      @result = QueryResult.new
      page_token = execute_query
      fetch_pagenated_result(page_token)
      @result
    end

    private

    def execute_query
      response = @client.jobs_query(@query, @options)
      fields = response['schema']['fields']
      @result.job_id = response['jobReference']['jobId']
      @result.column_names = fields.map {|field| field['name'] }
      @result.column_types = fields.map {|field| field['type'] }
      @result.records = extract_records(response)
      response['pageToken']
    end

    def fetch_pagenated_result(page_token)
      while page_token
        response = @client.query_results(@result.job_id, { pageToken: page_token }.merge(@options))
        @result.records += extract_records(response)
        page_token = response['pageToken']
      end
    end

    def extract_records(response)
      (response['rows'] || []).map {|row| row['f'].map {|record| record['v'] } }
    end
  end
end
