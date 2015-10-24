require 'helper'

class AttributeTest < Test::Unit::TestCase
  def test_boolean
    boolean = BigQuery::Attribute::BOOLEAN.new('true', 'BOOLEAN', 'is_admin')
    assert { boolean.parse == true }
    assert { boolean.value == 'true' }
    assert { boolean.type  == 'BOOLEAN' }
    assert { boolean.name  == 'is_admin' }
  end

  def test_string
    string = BigQuery::Attribute::STRING.new('foo', 'STRING', 'is_admin')
    assert { string.parse == "foo" }
  end
end
