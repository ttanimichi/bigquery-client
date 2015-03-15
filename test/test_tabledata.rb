require 'helper'

class TablesTest < Test::Unit::TestCase
  def test_insert
    prepare_table(__method__)
    result = $client.insert(table_name, bar: "foo")
    assert { result['kind'] == 'bigquery#tableDataInsertAllResponse' }
  end

  def test_insert_with_array
    prepare_table(__method__)
    rows = [{ bar: "foo" },  { bar: "foo2" },  { bar: "foo3" }]
    result = $client.insert(table_name, rows)
    assert { result['kind'] == 'bigquery#tableDataInsertAllResponse' }
  end

  def test_list_tabledata
    prepare_table(__method__)
    result = $client.list_tabledata(table_name)
    assert { result['kind'] == "bigquery#tableDataList" }
  end

  def prepare_table(name)
    table_name = name.to_s
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
  end
end
