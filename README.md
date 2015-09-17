# BigQuery Client

[![Gem Version](https://badge.fury.io/rb/bigquery-client.svg)](http://badge.fury.io/rb/bigquery-client)

A Ruby interface to the BigQuery API.

## Installation

```
% gem install bigquery-client
```

## Getting Started

```ruby
require "bigquery-client"

client = BigQuery::Client.new(
  project:                "your-project-42",
  dataset:                "your_dataset",
  email:                  "1234567890@developer.gserviceaccount.com",
  private_key_path:       "/path/to/keyfile.p12",
  private_key_passphrase: "notasecret",
  auth_method:            "private_key"
)

client.sql "SELECT * FROM publicdata:samples.wikipedia LIMIT 10"
```

## Available API methods

https://cloud.google.com/bigquery/docs/reference/v2/

| Resource type | Method          | Function                      | Support               |
|---------------|-----------------|-------------------------------|:---------------------:|
| Tabledata     | insertAll       | `insert`, `insert_all`        | :white_check_mark:    |
| Tabledata     | list            | `list_tabledata`              | :white_check_mark:    |
| Tables        | list            | `tables`, `list_tables`       | :white_check_mark:    |
| Tables        | get             | `fetch_schema`, `fetch_table` | :white_check_mark:    |
| Tables        | insert          | `create_table`                | :white_check_mark:    |
| Tables        | patch           | `patch_table`                 | :white_check_mark:    |
| Tables        | update          | `update_table`                | :white_check_mark:    |
| Tables        | delete          | `delete_table`                | :white_check_mark:    |
| Jobs          | query           | `sql`, `jobs_query`           | :white_check_mark:    |
| Jobs          | insert          | `load`                        | :white_check_mark:    |
| Jobs          | list            | `jobs`                        | :white_check_mark:    |
| Jobs          | get             | `fetch_job`                   | :white_check_mark:    |
| Jobs          | getQueryResults | `query_results`               | :white_check_mark:    |
| Datasets      | list            | `datasets`, `list_datasets`   | :white_check_mark:    |
| Datasets      | get             | `fetch_dataset`               | :white_medium_square: |
| Datasets      | insert          | `create_dataset`              | :white_check_mark:    |
| Datasets      | patch           | `patch_dataset`               | :white_medium_square: |
| Datasets      | update          | `update_dataset`              | :white_medium_square: |
| Datasets      | delete          | `delete_dataset`              | :white_check_mark:    |
| Projects      | list            | `projects`, `list_projects`   | :white_check_mark:    |

## Basic Usage

```ruby
# insert
client.insert("your_table", nickname: "john", age: 42)

# insert multiple rows
rows = [
  { nickname: "foo", age: 43 },
  { nickname: "bar", age: 44 }
]
client.insert("your_table", rows)

# create table
schema = [
  { name: "foo", type: "timestamp" },
  { name: "bar", type: "string"    }
]
client.create_table("new_table", schema)

# SQL
client.sql "SELECT * FROM your_dataset.your_table LIMIT 100"

# SQL (public data)
client.sql "SELECT born_alive_alive,is_male,weight_pounds FROM publicdata:samples.natality LIMIT 3"
#=> [{"born_alive_alive"=>0, "is_male"=>true, "weight_pounds"=>8.437090766739999}, {"born_alive_alive"=>2, "is_male"=>true, "weight_pounds"=>6.8122838958}, {"born_alive_alive"=>4, "is_male"=>false, "weight_pounds"=>6.9996768185}]

# query
client.query "SELECT born_alive_alive,is_male,weight_pounds FROM publicdata:samples.natality LIMIT 3"
#=> #<struct BigQuery::QueryResult job_id="job_wNWRgrTUJKIi-IUFf9bIqe1mpU8", column_names=["born_alive_alive", "is_male", "weight_pounds"], column_types=["INTEGER", "BOOLEAN", "FLOAT"], records=[["0", "true", "8.437090766739999"], ["2", "true", "6.8122838958"], ["4", "false", "6.9996768185"]]>

# tables
client.tables
#=> ["your_table", "your_table2", "your_table3"]

# fetch schema
client.fetch_schema("your_table")
#=> [{"name"=>"nickname", "type"=>"STRING"}, {"name"=>"age", "type"=>"INTEGER"}]

# delete table
client.delete_table('your_table')
```

## Datasets API

```ruby
# No need to specify `:dataset`
client = BigQuery::Client.new(
  project:                "your-project-42",
  email:                  "1234567890@developer.gserviceaccount.com",
  private_key_path:       "/path/to/keyfile.p12",
  private_key_passphrase: "notasecret",
  auth_method:            "private_key"
)

client.datasets
#=> ["your_dataset", "your_dataset2"]

# create dataset
client.create_dataset('your_dataset')

# delete dataset
client.delete_dataset('your_dataset')
```

## Projects API

```ruby
# No need to specify `:project` and `:dataset`
client = BigQuery::Client.new(
  email:                  "1234567890@developer.gserviceaccount.com",
  private_key_path:       "/path/to/keyfile.p12",
  private_key_passphrase: "notasecret",
  auth_method:            "private_key"
)

client.projects
#=> ["your_project"]
```

## TODO

- [ ] Support all API methods
- [ ] Improve `load`
  - Support load-from-GCS flow and POST-request flow
  - ref. https://cloud.google.com/bigquery/loading-data-into-bigquery
- [ ] Support OAuth installed application credentials
- [ ] Google API discovery expiration

## How to run tests

Please create a file named `.env` on the root of this repository. You can use `.env.example` file as a template.

```
% cp .env.example .env
```

and edit `.env` file properly.

```
BIGQUERY_PROJECT=your-project-42
BIGQUERY_EMAIL=1234567890@developer.gserviceaccount.com
BIGQUERY_PRIVATE_KEY_PATH=/path/to/keyfile.p12
```

Then run tests.

```
% bundle install
% bundle exec rake
```

## Contributing

1. Fork it ( https://github.com/ttanimichi/bigquery-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
