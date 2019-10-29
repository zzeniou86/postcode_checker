require 'test_helper'

class PostcodesChecker < ActiveSupport::TestCase
  setup do
    VCR.insert_cassette('postcodes_io/lookup')
    @client = PostcodesIo::Client.new
  end

  teardown do
    VCR.eject_cassette
  end

  test 'returns error on failure for invalid format' do
    command = PostcodeChecker.call(@client, 'INVALIDPOSTCODE', [], [])

    assert command.failure?
    assert command.errors.key?(:whitelist_checker)
  end

  test 'returns error on failure for a not found postcode' do
    command = PostcodeChecker.call(@client, 'SH24 1AA', [], [])

    assert command.failure?
    assert command.errors.key?(:whitelist_checker)
  end

  test 'returns false for a non-whitelisted postcode' do
    command = PostcodeChecker.call(@client, 'SE1 7QD', [], [])

    assert command.success?
    assert_equal false, command.result
  end

  test 'returns true for a lsoa whitelisted postcode' do
    lsoa_whitelist = ['Southwark']
    command = PostcodeChecker.call(@client, 'SE1 7QD', [], lsoa_whitelist)

    assert command.success?
    assert_equal true, command.result
  end

  test 'returns true for a postcode whitelisted postcode that does not exist in postcode.io' do
    postcode_whitelist = ['SH24 1AB', 'SH24 1AA']
    command = PostcodeChecker.call(@client, 'SH24 1AA', postcode_whitelist, [])

    assert command.success?
    assert_equal true, command.result
  end

  test 'postcode parse' do
    postcode_whitelist = ['SH24 1AB', 'SH24 1AA']
    command = PostcodeChecker.call(@client, ' sH24 1Aa ', postcode_whitelist, [])

    assert command.success?
    assert_equal true, command.result
  end
end
