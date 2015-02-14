$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'test/unit'
require 'bigquery-client'
require 'dotenv'
require 'awesome_print'
require 'pry-byebug'

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

Dotenv.load

$dataset = 'test_bigquery_client'

$client = BigQuery::Client.new(
  project:                ENV['BIGQUERY_PROJECT'],
  email:                  ENV['BIGQUERY_EMAIL'],
  private_key_path:       ENV['BIGQUERY_PRIVATE_KEY_PATH'],
  dataset:                $dataset,
  private_key_passphrase: 'notasecret',
  auth_method:            'private_key'
)

$client.datasets.select { |dataset|
  Regexp.new($dataset) =~ dataset
}.each { |dataset|
  $client.delete_dataset(dataset)
}

$client.create_dataset($dataset)
