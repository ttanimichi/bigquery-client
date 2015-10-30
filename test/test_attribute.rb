require 'helper'

class AttributeTest < Test::Unit::TestCase
  def test_attribute
    attribute = BigQuery::Attribute.new(name: 'is_admin', type: 'BOOLEAN', value: 'true')
    assert { attribute.parse == true }
    assert { attribute.name  == 'is_admin' }
    assert { attribute.value == 'true' }
    assert { attribute.type  == :boolean }
  end

  def test_string
    attribute = BigQuery::Attribute::String.new(nil, 'foo')
    assert { attribute.parse == 'foo' }
    assert { attribute.type  == :string }
  end

  def test_string_nil
    attribute = BigQuery::Attribute::String.new(nil, nil)
    assert { attribute.parse.nil? }
  end

  def test_integer
    attribute = BigQuery::Attribute::Integer.new(nil, '42')
    assert { attribute.parse == 42 }
    assert { attribute.type  == :integer }
  end

  def test_integer_nil
    attribute = BigQuery::Attribute::Integer.new(nil, nil)
    assert { attribute.parse.nil? }
  end

  def test_float
    attribute = BigQuery::Attribute::Float.new(nil, '6.4992274837599995')
    assert { attribute.parse == 6.4992274837599995 }
    assert { attribute.type  == :float }
  end

  def test_float_nil
    attribute = BigQuery::Attribute::Float.new(nil, nil)
    assert { attribute.parse.nil? }
  end

  def test_boolean
    attribute = BigQuery::Attribute::Boolean.new(nil, 'false')
    assert { attribute.parse == false }
    assert { attribute.type  == :boolean }
  end

  def test_boolean_nil
    attribute = BigQuery::Attribute::Boolean.new(nil, nil)
    assert { attribute.parse.nil? }
  end

  def test_timestamp
    attribute = BigQuery::Attribute::Timestamp.new(nil, "-5.51952E7")
    assert { attribute.parse == Time.new(1968, 4, 2, 13, 0, 0) }
    assert { attribute.type  == :timestamp }
  end

  def test_timestamp_nil
    attribute = BigQuery::Attribute::Timestamp.new(nil, nil)
    assert { attribute.parse.nil? }
  end
end
