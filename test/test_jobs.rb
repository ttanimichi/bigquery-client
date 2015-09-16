require 'helper'

class JobsTest < Test::Unit::TestCase
  def test_sql
    query = <<-"EOS"
      SELECT
        born_alive_alive, mother_residence_state, is_male, weight_pounds
      FROM
        publicdata:samples.natality
      ORDER BY
        day
      LIMIT
        100
    EOS
    result = $client.sql(query)
    assert { result.size == 100 }
    assert { result.sample["born_alive_alive"].is_a? Fixnum }
    assert { result.sample["mother_residence_state"].is_a? String }
    assert { result.sample["weight_pounds"].is_a? Float }
    assert { result.first["is_male"] == true || result.first["is_male"] == false }
    # TODO: Add a test of TIMESTAMP columns
  end

  def test_sql_when_no_rows
    no_rows_query = <<-"EOS"
      SELECT
        *
      FROM
        publicdata:samples.natality
      LIMIT
        0
    EOS
    assert { $client.sql(no_rows_query) == [] }
  end

  def test_sql_pagination
    pagination_query = <<-"EOS"
      SELECT
        title
      FROM
        publicdata:samples.wikipedia
      LIMIT
        123
    EOS
    assert { $client.sql(pagination_query, maxResults: 100).size == 123 }
  end
end
