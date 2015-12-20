module BigQuery
  module Service
    class RunQuery
      def initialize(client, query, options)
        @client, @query, @options = client, query, options
      end

      def call
        @result = ResultSet.new
        execute_query
        fetch_pagenated_result
        @result
      end

      private

      def execute_query
        response = @client.jobs_query(@query, @options)
        @page_token = response['pageToken']
        fields = response['schema']['fields']
        @result.job_id = response['jobReference']['jobId']
        @result.column_names = fields.map {|field| field['name'] }
        @result.column_types = fields.map {|field| field['type'] }
        @result.records = extract_records(response)
      end

      def fetch_pagenated_result
        while @page_token
          response = @client.query_results(@result.job_id, { pageToken: @page_token }.merge(@options))
          @result.records += extract_records(response)
          @page_token = response['pageToken']
        end
      end

      def extract_records(response)
        (response['rows'] || []).map {|row| row['f'].map {|record| record['v'] } }
      end
    end
  end
end
