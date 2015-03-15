require 'helper'

class TablesTest < Test::Unit::TestCase
  def test_tables
    table_name = 'test_tables'
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    assert { $client.tables.include?(table_name) }
  end

  def test_fetch_schema
    table_name = 'test_fetch_schema'
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    result = $client.fetch_schema(table_name)
    assert { result == [{"name"=>"bar", "type"=>"STRING"}] }
  end

  def test_create_table
    table_name = 'test_create_table'
    schema = [{ name: 'bar', type: 'string' }]
    before = $client.tables
    $client.create_table(table_name, schema)
    after  = $client.tables
    actual = after - before
    expected = [table_name]
    assert { expected == actual }
  end

  def test_delete_table
    table_name = 'test_delete_table'
    schema = [ {name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    before = $client.tables
    $client.delete_table(table_name)
    after  = $client.tables
    actual = before - after
    expected = [table_name]
    assert { actual == expected }
  end
end
