# https://cloud.google.com/bigquery/docs/reference/v2/tabledata

module BigQuery
  module Tabledata


    # insert バグってる
    #
    # [5] pry(main)> client.insert('test_timestamp', foo: "2015-10-13 20:05:43 +0900")
    # => {"kind"=>"bigquery#tableDataInsertAllResponse", "insertErrors"=>[{"index"=>0, "errors"=>[{"reason"=>"invalid", "location"=>"Field:foo", "message"=>"Could not parse '2015-10-13 20:05:43 +0900' as a timestamp. Required format is YYYY-MM-DD HH:MM[:SS[.SSSSSS]]"}]}]}
    # [6] pry(main)> client.insert('test_timestamp', foo: "2015-10-13 20:05:43")
    # => {"kind"=>"bigquery#tableDataInsertAllResponse"}
    #
    # handle_result みたいなメソッドを足す
    # service クラスにしたほうがいいかも
    def insert(table, arg)
      rows = arg.is_a?(Array) ? arg : [arg]
      access_api(
        api_method: bigquery.tabledata.insert_all,
        parameters: {
          tableId: table
        },
        body_object: {
          rows: rows.map { |row| { json: row } }
        }
      )
    end
    alias_method :insert_all, :insert

    def list_tabledata(table)
      access_api(
        api_method: bigquery.tabledata.list,
        parameters: {
          tableId: table
        }
      )
    end
  end
end
