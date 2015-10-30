require 'helper'

class TablesTest < ApiTest
  def test_tables
    table_name = __method__.to_s
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    assert { $client.tables.include?(table_name) }
  end

  def test_fetch_schema
    table_name = __method__.to_s
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    assert { $client.fetch_schema(table_name) == [{"name"=>"bar", "type"=>"STRING"}] }
  end

  def test_create_table
    table_name = __method__.to_s
    schema = [{ name: 'bar', type: 'string' }]
    before = $client.tables
    $client.create_table(table_name, schema)
    after = $client.tables
    assert { (after - before) == [table_name] }
  end

  def test_delete_table
    table_name = __method__.to_s
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    before = $client.tables
    $client.delete_table(table_name)
    after  = $client.tables
    assert { (before - after) == [table_name] }
  end

  def test_table_pagination
    $client.tables.each {|t| $client.delete_table(t) }
    3.times do |i|
      table_name = __method__.to_s + "_#{i.to_s}"
      schema = [{ name: 'bar', type: 'string' }]
      $client.create_table(table_name, schema)
    end
    assert { $client.tables(maxResults: 1).count == 3 }
  end
end
