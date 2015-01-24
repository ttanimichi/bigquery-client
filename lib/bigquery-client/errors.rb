module BigQuery
  class APIError < StandardError
  end

  # HTTP 4xx Client Error
  class ClientError < APIError
  end

  # HTTP 404 Not Found
  class NotFound < ClientError
  end

  # HTTP 409 Conflict
  class Conflict < ClientError
  end

  # HTTP 5xx Server Error
  class ServerError < APIError
  end

  class UnexpectedError < APIError
  end
end
