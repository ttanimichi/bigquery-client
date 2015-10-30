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
        if errors = @client.insert_all(@table, @rows)['insertErrors']
          handle_errors(errors)
        end
      end

      def handle_errors(errors)
        fail InsertError, errors
      end
    end
  end
end
