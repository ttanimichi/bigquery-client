# BigQuery Client

[![Gem Version](https://badge.fury.io/rb/bigquery-client.svg)](http://badge.fury.io/rb/bigquery-client)
[![Build Status](https://travis-ci.org/ttanimichi/bigquery-client.png)](https://travis-ci.org/ttanimichi/bigquery-client)

A Ruby interface to the BigQuery API.

## Installation

```
% gem install bigquery-client
```

## Usage

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

## Contributing

1. Fork it ( https://github.com/ttanimichi/bigquery-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
