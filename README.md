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

client.show hoge hoge

```

## Available API methods

ref. https://cloud.google.com/bigquery/docs/reference/v2/

| Resource type | Method          | Function           | Support               |
|---------------|-----------------|--------------------|:---------------------:|
| Tables        | delete          | `drop_table`       | :white_check_mark:    |
| Tables        | get             | `fetch_table_info` | :white_check_mark:    |
| Tables        | get             | `fetch_schema`     | :white_check_mark:    |
| Tables        | insert          | `create_table`     | :white_check_mark:    |
| Tables        | list            | `list_tables`      | :white_check_mark:    |
| Tables        | patch           | `patch_table`      | :white_check_mark:    |
| Tables        | update          | `update_table`     | :white_check_mark:    |
| Tabledata     | insertAll       |                    | :white_medium_square: |
| Tabledata     | list            | `list_table`       | :white_check_mark:    |
| Datasets      | delete          |                    | :white_medium_square: |
| Datasets      | get             |                    | :white_medium_square: |
| Datasets      | insert          |                    | :white_medium_square: |
| Datasets      | list            | `list_datasets`    | :white_check_mark:    |
| Datasets      | patch           |                    | :white_medium_square: |
| Datasets      | update          |                    | :white_medium_square: |
| Jobs          | get             |                    | :white_medium_square: |
| Jobs          | getQueryResults |                    | :white_medium_square: |
| Jobs          | insert          |                    | :white_medium_square: |
| Jobs          | list            |                    | :white_medium_square: |
| Jobs          | query           |                    | :white_medium_square: |
| Projects      | list            | `list_projects`    | :white_check_mark:    |

## Usage

```ruby
# insert
client.insert("your_table", uid: "john", age: 42)

# insert multiple rows
rows = [
  { uid: "foo", age: 43 },
  { uid: "bar", age: 44 }
]
client.insert("your_table", rows)

# create table
schema = [
  { name: "foo", type: "timestamp" },
  { name: "bar", type: "string"    }
]
client.create_table("new_table", schema)

# fetch schema
client.fetch_schema("your_table")
#=> [{"name"=>"uid", "type"=>"STRING"}, {"name"=>"age", "type"=>"INTEGER"}]
```

## TODO

- [ ] Support all API methods
- [ ] Support OAuth installed application credentials
- [ ] Google API discovery expiration

## Contributing

1. Fork it ( https://github.com/ttanimichi/bigquery-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
