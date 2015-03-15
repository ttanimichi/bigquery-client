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

## Usage

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
client.sql "SELECT * FROM publicdata:samples.wikipedia LIMIT 10"

# tables
client.tables
#=> ["your_table", "your_table2", "your_table3"]

# datasets
client.datasets
#=> ["your_dataset", "your_dataset2"]

# fetch schema
client.fetch_schema("your_table")
#=> [{"name"=>"nickname", "type"=>"STRING"}, {"name"=>"age", "type"=>"INTEGER"}]

# delete table
client.delete_table('your_table')

# create dataset
client.create_dataset('your_dataset')

# delete dataset
client.delete_dataset('your_dataset')
```

## TODO

- [ ] Support all API methods
- [ ] Improve `load`
  - Support load-from-GCS flow and POST-request flow
  - ref. https://cloud.google.com/bigquery/loading-data-into-bigquery
- [ ] Support OAuth installed application credentials
- [ ] Google API discovery expiration

## Contributing

1. Fork it ( https://github.com/ttanimichi/bigquery-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
