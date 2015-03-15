require 'helper'

class ClientTest < Test::Unit::TestCase
  def test_initialize
    actual  = $client.instance_variables
    minimal = [:@project, :@dataset, :@email, :@private_key_path, :@private_key_passphrase, :@auth_method]
    assert { minimal - actual == [] }
  end
end
