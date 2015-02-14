require 'helper'

class ProjectsTest < Test::Unit::TestCase
  def test_projects
    actual = $client.projects.first
    expected = ENV['BIGQUERY_PROJECT']
    assert { actual == expected }
  end

  def test_list_projects
    actual = $client.list_projects['projects'].first['id']
    expected = ENV['BIGQUERY_PROJECT']
    assert { actual == expected }
  end
end
