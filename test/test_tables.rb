require 'helper'

class TablesTest < Test::Unit::TestCase
  def test_tables
    table_name = 'test_tables'
    schema = [{ name: 'bar', type: 'string' }]
    $client.create_table(table_name, schema)
    assert { $client.tables.include?(table_name) }
  end

  def test_fetch_table
    # ap @client.fetch_table('my_table')
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

  def test_update_table
    # @client.tables.each do |table|
    #   @client.delete_table(table)
    # end

    # table_name = 'test_update_table'

    # schema = [
    #   { name: 'foo', type: 'timestamp' },
    #   { name: 'bar', type: 'string'    }
    # ]
    # @client.create_table(table_name, schema)

    # schema = [
    #   { name: "foo", type: "timestamp" },
    #   { name: "bar", type: "string"    },
    #   { name: "buz", type: "string"    },
    #   { name: "buz2", type: "string"    }
    # ]
    # ap @client.update_table(table_name, schema)
  end

  def test_patch_table
    # table_name = 'test_patch_table'

    # schema = [
    #   { name: 'foo', type: 'timestamp' },
    #   { name: 'bar', type: 'string'    }
    # ]
    # @client.create_table(table_name, schema)

    # schema = [
    #   { name: "foo", type: "timestamp" },
    #   { name: "bar", type: "string"    },
    #   { name: "buz", type: "string"    },
    #   { name: "buz2", type: "string"    }
    # ]
    # ap @client.patch_table(table_name, schema)
  end
end
