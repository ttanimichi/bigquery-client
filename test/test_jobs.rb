require 'helper'

class JobsTest < Test::Unit::TestCase
  @@query = <<-"EOS"
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

  def test_sql
    result = $client.sql(@@query)
    assert { result.size == 100 }
    assert { result.sample["born_alive_alive"].is_a? Fixnum }
    assert { result.sample["mother_residence_state"].is_a? String }
    assert { result.sample["is_male"] == true || result.first["is_male"] == false }
  end

  def test_sql_when_no_rows
    result = $client.sql(@@no_rows_query)
    assert { result == [] }
  end
end
