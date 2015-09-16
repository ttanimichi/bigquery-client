$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'test/unit'
require 'bigquery-client'
require 'dotenv'
require 'awesome_print'
require 'pry-byebug'
require 'vcr'

Dotenv.load

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

VCR.configure do |config|
  config.cassette_library_dir = "vcr_cassettes"
  config.hook_into :webmock
end

$prefix  = 'test_bigquery_client'
$dataset = "#{$prefix}_default"

$client = BigQuery::Client.new(
  project:                ENV['BIGQUERY_PROJECT'],
  email:                  ENV['BIGQUERY_EMAIL'],
  private_key_path:       ENV['BIGQUERY_PRIVATE_KEY_PATH'],
  dataset:                $dataset,
  private_key_passphrase: 'notasecret',
  auth_method:            'private_key'
)

VCR.use_cassette("helper") do
  $client.datasets.each do |dataset|
    $client.delete_dataset(dataset) if Regexp.new($prefix) =~ dataset
  end
  $client.create_dataset($dataset)
end

Test::Unit::TestCase.class_eval do
  def setup
    VCR.insert_cassette("#{self.class}_#{@method_name}")
  end

  def cleanup
    VCR.eject_cassette
  end
end
