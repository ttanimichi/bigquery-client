require 'helper'

class ProjectsTest < ApiTest
  def test_projects
    assert { $client.projects.include? ENV['BIGQUERY_PROJECT'] }
  end
end
