require 'helper'

class DatasetsTest < Test::Unit::TestCase
  def test_datasets
    dataset_name = "#{$prefix}_#{__method__}"
    unless $client.datasets.include?(dataset_name)
      $client.create_dataset(dataset_name)
    end
    assert { $client.datasets.include?(dataset_name) }
  end

  def test_create_dataset
    dataset_name = "#{$prefix}_#{__method__}"
    if $client.datasets.include?(dataset_name)
      $client.delete_dataset(dataset_name)
    end
    before = $client.datasets
    $client.create_dataset(dataset_name)
    after = $client.datasets
    assert { (after - before) == [dataset_name] }
  end

  def test_delete_dataset
    dataset_name = "#{$prefix}_#{__method__}"
    $client.create_dataset(dataset_name)
    before = $client.datasets
    $client.delete_dataset(dataset_name)
    after = $client.datasets
    assert { (before - after) == [dataset_name] }
  end
end
