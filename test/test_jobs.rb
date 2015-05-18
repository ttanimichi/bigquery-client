require 'helper'

class JobsTest < Test::Unit::TestCase
  @@normal_query = <<-"EOS"
    SELECT
      born_alive_alive, mother_residence_state, is_male
    FROM
      publicdata:samples.natality
    ORDER BY
      day
    LIMIT
      100
  EOS

  @@no_rows_query = <<-"EOS"
    SELECT
      born_alive_alive, mother_residence_state, is_male
    FROM
      publicdata:samples.natality
    ORDER BY
      day
    LIMIT
      0
  EOS

  @@huge_result_query = <<-"EOS"
    SELECT
      title
    FROM
      publicdata:samples.wikipedia
    LIMIT
      1234567
  EOS

  def test_sql
    result = $client.sql(@@normal_query)
    assert { result.size == 100 }
    assert { result.sample["born_alive_alive"].is_a? Fixnum }
    assert { result.sample["mother_residence_state"].is_a? String }
    assert { result.first["is_male"] == true || result.first["is_male"] == false }
  end

  def test_sql_when_no_rows
    result = $client.sql(@@no_rows_query)
    assert { result == [] }
  end

  def test_sql_pagination
    record_size = $client.sql(@@huge_result_query).size
    assert { record_size == 1234567 }
  end
end
