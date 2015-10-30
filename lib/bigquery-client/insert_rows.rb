module BigQuery
  module Tabledata
    class InsertRows
      class InsertError < StandardError
      end

      def initialize(client, table, arg)
        @client, @table = client, table
        @rows = arg.is_a?(Array) ? arg : [arg]
      end

      def call
        result = @client.insert_all(@table, @rows)
        handle_errors(result['insertErrors']) if result['insertErrors']
        result
      end

      def handle_errors(errors)
        fail InsertError, errors
      end
    end
  end
end
