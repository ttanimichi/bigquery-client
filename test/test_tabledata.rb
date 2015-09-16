require 'helper'

class TabledataTest < Test::Unit::TestCase
  def test_insert
    table_name = __method__.to_s
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    result = $client.insert(table_name, bar: "foo")
    assert { result['kind'] == 'bigquery#tableDataInsertAllResponse' }
  end

  def test_insert_with_array
    table_name = __method__.to_s
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    result = $client.list_tabledata(table_name)
    rows = [{ bar: "foo" },  { bar: "foo2" },  { bar: "foo3" }]
    result = $client.insert(table_name, rows)
    assert { result['kind'] == 'bigquery#tableDataInsertAllResponse' }
  end

  def test_list_tabledata
    table_name = __method__.to_s
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    result = $client.list_tabledata(table_name)
    assert { result['kind'] == "bigquery#tableDataList" }
  end
end
