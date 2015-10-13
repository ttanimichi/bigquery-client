require 'helper'

class JobsTest < Test::Unit::TestCase
  NORMAL_QUERY = <<-"EOS"
    SELECT
      born_alive_alive, mother_residence_state, is_male, weight_pounds
    FROM
      publicdata:samples.natality
    ORDER BY
      day
    LIMIT
      100
  EOS

  def test_sql
    result = $client.sql NORMAL_QUERY
    assert { result.size == 100 }
    assert { result.sample["born_alive_alive"].is_a? Fixnum }
    assert { result.sample["mother_residence_state"].is_a? String }
    assert { result.sample["weight_pounds"].is_a? Float }
    assert { result.first["is_male"] == true || result.first["is_male"] == false }
  end

  def test_sql_timestamp_columns
    table_name = 'test_timestamp'
    $client.create_table(table_name, [{ name: 'time', type: 'timestamp' }])
    $client.insert(table_name, time: "2015-10-13 20:05:43")
    result = $client.sql('SELECT * FROM test_bigquery_client_default.test_timestamp LIMIT 1')
    assert { result.last["time"] == Time.parse("2015-10-13 20:05:43 UTC") }
  end

  def test_query
    result = $client.query NORMAL_QUERY
    assert { result.column_names == %w(born_alive_alive mother_residence_state is_male weight_pounds) }
    assert { result.column_types == %w(INTEGER STRING BOOLEAN FLOAT) }
    records = result.records
    assert { records.size == 100 }
    assert { records.is_a?(Array) && records.sample.is_a?(Array) }
    assert { records.sample.size == 4 }
    assert { records.sample.all? {|value| value.is_a?(String) } }
  end

  def test_sql_when_no_rows
    no_rows_query = 'SELECT * FROM publicdata:samples.natality LIMIT 0'
    assert { $client.sql(no_rows_query) == [] }
  end

  def test_sql_pagination
    pagination_query = 'SELECT title FROM publicdata:samples.wikipedia LIMIT 123'
    assert { $client.sql(pagination_query, maxResults: 100).size == 123 }
  end
end
