require 'helper'

class DatasetsTest < Test::Unit::TestCase
  def test_datasets
    dataset_name = "#{$dataset}_test_datasets"
    $client.create_dataset(dataset_name)
    $client.datasets.include?(dataset_name)
  end

  def test_create_dataset
    dataset_name = "#{$dataset}_create_dataset"
    $client.create_dataset(dataset_name)
  end

  def test_delete_dataset
    dataset_name = "#{$dataset}_delete_dataset"
    $client.create_dataset(dataset_name)
    before = $client.datasets
    $client.delete_dataset(dataset_name)
    after = $client.datasets
    actual = before - after
    expected = [dataset_name]
    assert { actual == expected }
  end
end
