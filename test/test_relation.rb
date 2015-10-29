require 'helper'

class RelationTest < Test::Unit::TestCase
  def setup
    @column_names = ['age', 'name', 'is_admin', 'weight']
    @column_types = ['INTEGER', 'STRING', 'BOOLEAN', 'FLOAT']
    @records = [
      ['0', 'IA', 'true', '8.375361333379999'],
      ['0', 'IA', 'false', '5.6879263596'],
      ['1', 'IA', 'false', '6.686620406459999']
    ]
  end

  def test_fuga
    relation = BigQuery::Relation.build(@column_names, @column_types, @records)
    binding.pry

    1
    # relation.schema
    # # => {"age"=>"INTEGER", "name"=>"STRING", "is_admin"=>"BOOLEAN", "weight"=>"FLOAT"}

    # [6] pry(#<RelationTest>)> relation.first.class
    #   => BigQuery::Tuple
    # [7] pry(#<RelationTest>)> relation.last.class
    #   => BigQuery::Tuple
    # [8] pry(#<RelationTest>)> relation[2].class
    #   => BigQuery::Tuple
  end
end
