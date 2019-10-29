require 'test_helper'

class PostcodesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get postcodes_url

    assert_response :success
  end

  test "postcodes#check_whitelist - success response on whitelisted postcode" do
    VCR.use_cassette('postcodes_io/lookup') do
      post postcodes_check_whitelist_url, params: { query: 'SE17QD' }, xhr: true

      assert_response :success
    end
  end

  test "postcodes#check_whitelist - success response on non-whitelisted postcode" do
    VCR.use_cassette('postcodes_io/lookup') do
      post postcodes_check_whitelist_url, params: { query: 'SW112NW' }, xhr: true

      assert_response :success
    end
  end

  test "postcodes#check_whitelist - bad request response on bad formatted postcode (format error)" do
    VCR.use_cassette('postcodes_io/lookup') do
      post postcodes_check_whitelist_url, params: { query: 'INVALIDPOSTCODE' }, xhr: true

      assert_response :bad_request
    end
  end

  test "postcodes#check_whitelist - bad request response on non-found postcode (client error)" do
    VCR.use_cassette('postcodes_io/lookup') do
      post postcodes_check_whitelist_url, params: { query: 'SW112NF' }, xhr: true

      assert_response :bad_request
    end
  end
end
