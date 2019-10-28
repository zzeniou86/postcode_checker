require 'test_helper'

class PostcodesIoClientTest < ActiveSupport::TestCase
  # this is a behaviour/interface test for the client. We can change the underline library (i.e. change from
  # HTTParty to Faraday), as long as the client implements the lookup function
  test 'implements lookup method' do
    client = PostcodesIo::Client.new
    assert_respond_to client, :lookup
  end

  test 'returns Hash with keys status and results on success' do
    client = PostcodesIo::Client.new

    VCR.use_cassette('postcodes_io/lookup') do
      response = client.lookup('SE17QD')

      assert response.key? 'status'
      assert response.key? 'result'
    end
  end

  test 'returns Hash with keys status and error on failure' do
    client = PostcodesIo::Client.new

    VCR.use_cassette('postcodes_io/lookup') do
      response = client.lookup('INVALIDPOSTCODE')

      assert_instance_of Hash, response
      assert response.key? 'status'
      assert response.key? 'error'
    end
  end
end
