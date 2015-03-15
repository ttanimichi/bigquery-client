require 'helper'

class TablesTest < Test::Unit::TestCase
  def test_insert
    table_name = 'test_insert'
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    result = $client.insert(table_name, bar: "foo")
    assert { result['kind'] == 'bigquery#tableDataInsertAllResponse' }
  end

  def test_insert_with_array
    table_name = 'test_insert_with_array'
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    rows = [{ bar: "foo" },  { bar: "foo2" },  { bar: "foo3" }]
    result = $client.insert(table_name, rows)
    assert { result['kind'] == 'bigquery#tableDataInsertAllResponse' }
  end
end
