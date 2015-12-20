module BigQuery
  module Service
    class FetchTables
      def initialize(client, options)
        @client, @options = client, options
        @results = []
      end

      def call
        loop do
          response = @client.list_tables({ pageToken: @page_token }.merge(@options))
          @results += (response['tables'] || []).map {|table| table['tableReference']['tableId'] }
          return @results unless (@page_token = response['nextPageToken'])
        end
      end
    end
  end
end
