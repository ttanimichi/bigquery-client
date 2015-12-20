require 'helper'

class TabledataTest < ApiTest
  def test_insert
    table_name = __method__.to_s
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    assert { $client.insert(table_name, bar: "foo") == { 'kind' => 'bigquery#tableDataInsertAllResponse' } }
  end

  def test_insert_invalid_timestamp
    table_name = __method__.to_s
    schema = [{ name: 'time', type: 'timestamp' }]
    $client.create_table(table_name, schema)
    assert_raise(BigQuery::Service::InsertRows::InsertError) do
      $client.insert(table_name, time: "invalid_timestamp")
    end
  end

  def test_insert_with_array
    table_name = __method__.to_s
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    result = $client.list_tabledata(table_name)
    rows = [{ bar: "foo" },  { bar: "foo2" },  { bar: "foo3" }]
    assert { $client.insert(table_name, rows) == { 'kind' => 'bigquery#tableDataInsertAllResponse' } }
  end

  def test_list_tabledata
    table_name = __method__.to_s
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    result = $client.list_tabledata(table_name)
    assert { result['kind'] == "bigquery#tableDataList" }
  end
end
