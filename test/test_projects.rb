require 'helper'

class ProjectsTest < Test::Unit::TestCase
  def test_projects
    assert { $client.projects.include? ENV['BIGQUERY_PROJECT'] }
  end
end
