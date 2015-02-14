require 'helper'

class TablesTest < Test::Unit::TestCase
  def test_insert
    table_name = 'test_insert'
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    result = $client.insert(table_name, bar: "foo")
    assert { result['kind'] == 'bigquery#tableDataInsertAllResponse' }
  end

  # def test_insert_with_array
  #   assert { @client.insert('my_table', rows).nil? }
  # end
end
